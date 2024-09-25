from sqlalchemy.orm import Session
from .crud import get_db, load_running_logs, get_favorite_courses, get_courses, get_course_tags, get_members
from .models import Course as SQLACourse, Member as SQLAMember, CourseTags as SQLACourseTags, FavoriteCourse as SQLAFavoriteCourse
from .schema import Course, Member, CourseTags, FavoriteCourse  # Pydantic 스키마 임포트
from scipy.sparse import coo_matrix
from lightfm import LightFM
from joblib import dump
from prettytable import PrettyTable
import numpy as np
import pandas as pd  # 데이터프레임 처리
import os
import math, time


def sigmoid(x):
    return 1 / (1 + np.exp(-x))


def load_data(db: Session, log_filepath: str, member_id: int, lat: float, lng: float):
    # 1. ORM으로 데이터 불러오기
    start = time.time()
    courses = get_courses(db, lat, lng)
    end = time.time()
    print(f"{end - start:.5f} sec")
    course_tags = get_course_tags(db)
    favorite_courses = get_favorite_courses(db, member_id)
    # ORM 객체를 Pandas DataFrame으로 변환
    # courses_df = pd.DataFrame([{
    #     'course_id': course.course_id,
    #     'name': course.name,
    #     'address': course.address,
    #     'content': course.content,
    #     'level': course.level,
    #     'count': course.count,
    #     'average_slope': course.average_slope,
    #     'average_downhill': course.average_downhill,
    #     'average_time': str(course.average_time),
    #     'course_length': course.course_length,
    #     'member_id': course.member_id,
    #     'course_type': course.course_type,
    #     'regist_date': course.regist_date,
    #     'average_calorie': course.average_calorie,
    #     'lat': course.lat,
    #     'lng': course.lng,
    #     'course_image': {
    #         'courseId': course.course_image.course_id if course.course_image else None,
    #         'url': course.course_image.url if course.course_image else None,
    #         'path': course.course_image.path if course.course_image else None
    #     } if course.course_image else None
    # } for course, course_image in courses])
    courses_data = [
        {
            'course_id': course.course_id,
            'name': course.name,
            'address': course.address,
            'content': course.content,
            'level': course.level,
            'count': course.count,
            'average_slope': course.average_slope,
            'average_downhill': course.average_downhill,
            'average_time': str(course.average_time),
            'course_length': course.course_length,
            'member_id': course.member_id,
            'course_type': course.course_type,
            'regist_date': course.regist_date,
            'average_calorie': course.average_calorie,
            'lat': course.lat,
            'lng': course.lng,
            # 'course_image': {
            #     'courseId': course.course_image.course_id if course.course_image else None,
            #     'url': course.course_image.url if course.course_image else None,
            #     'path': course.course_image.path if course.course_image else None
            # } if course.course_image else None
        }
        for course in courses
    ]
    end = time.time()

    courses_df = pd.DataFrame.from_records(courses_data)
    
    print(f"{end - start:.5f} sec")

    print("Course data loaded:", courses_df.shape)
    course_tags_df = pd.DataFrame([{
        'course_id': tag.course_id,
        'tag_name': tag.tag_name
    } for tag in course_tags])

    print("Course tags data loaded:", course_tags_df.shape)

    favorite_course_df = pd.DataFrame([{
        'member_id': fav.member_id,
        'tag_name': fav.tag_name
    } for fav in favorite_courses])

    print("Favorite course data loaded:", favorite_course_df.shape)

    # 2. CSV 파일에서 실행 로그 불러오기
    if not os.path.exists(log_filepath):
        raise FileNotFoundError(f"File not found: {log_filepath}")
    
    logs_df = pd.read_csv(log_filepath)
    print("Running logs loaded:", logs_df.shape)
    # 3. 중복 로그 제거
    logs_df = logs_df.drop_duplicates(subset=['member_id', 'course_id'])
    print("Running logs after removing duplicates:", logs_df.shape)

    # 4. 코스와 태그 데이터 병합
    
    courses_with_tags_df = courses_df.merge(course_tags_df, on='course_id', how='left')
    print("Merged course and tags data:", courses_with_tags_df.shape)
    

    # 5. 로그와 선호 태그 데이터 병합
    logs_df = logs_df.merge(favorite_course_df[['member_id', 'tag_name']], on='member_id', how='left')
    print("Merged logs and favorite tags data:", logs_df.shape)
    
    # 6. 사용자와 코스의 상호작용 행렬 생성
    interactions = coo_matrix((np.ones(len(logs_df)), (logs_df['member_id'], logs_df['course_id'])))
    print("Interactions matrix shape:", interactions.shape)
    
    model = LightFM(loss='logistic')  # Logistic 손실 함수 사용
    
    

    print
    try:
        print("Fitting the model...")
        model.fit(interactions, epochs=50, num_threads=2)
        print("Model training completed.")
    except Exception as e:
        print(f"Error during model training: {e}")

    # 모델 저장
    dump(model, 'lightfm_model.joblib')
    print("Model saved as 'lightfm_model.joblib'.")
    print(interactions.shape)  # (사용자 수, 코스 수)

    # 추천 항목 가져오기
    user_id = member_id
    print(f"Generating recommendations for user {user_id}...")
    print(logs_df)

    user_logs = logs_df[logs_df['member_id'] == user_id]
    scores = model.predict(user_id, np.arange(interactions.shape[1]))
    scores = sigmoid(scores)
    # top_items를 courses_with_tags_df에서 필터링 후 중복 제거
    top_items = courses_with_tags_df[courses_with_tags_df['course_id'].isin(np.arange(interactions.shape[1]))].copy().drop_duplicates(subset=['course_id'])
          
    # 추천 점수 추가
    top_items['추천 점수'] = scores[top_items['course_id'].values]  # 여기서 index 맞추기
          
    # 추천 점수로 정렬 후 상위 5개만 선택
    top_items = top_items.sort_values(by='추천 점수', ascending=False).head(20)
    # PrettyTable 객체 생성
    table = PrettyTable()
    table.field_names = ["코스 ID", "이름", "레벨", "평균 경사", "주소", "참여자수", "코스 길이", "코스타입", "위도", "경도", "추천 점수"]

    # 상위 5개 추천 및 점수 추가
    for index, row in top_items.iterrows():
        table.add_row([row['course_id'], row['name'], row['level'], row['average_slope'], row['address'], row['count'], row['course_length'], row['course_type'], row['lat'], row['lng'], row['추천 점수']])
            
    # 출력
    print("추천 코스 (CF 기반):")
    print(table)
    # recommendations = top_items[['course_id', 'name', 'level', 'average_slope', '추천 점수']].to_dict(orient='records')
    recommendations = top_items[['course_id', 'name', 'level', 'average_slope', 'address', 'count', 'course_length', 'course_type', 'lat', 'lng', '추천 점수']].rename(columns={'course_id': 'courseId', 'average_slope' : 'averageSlope', 'course_length' : 'courseLength', 'course_type' : 'courseType', '추천 점수' : 'recommendationScore'}).to_dict(orient='records')
    return recommendations