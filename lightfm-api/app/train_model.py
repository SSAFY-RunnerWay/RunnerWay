from sqlalchemy.orm import Session
from .crud import get_db, load_running_logs, get_favorite_courses, get_courses, get_course_tags, get_members, get_recommendation_logs
from .models import Course as SQLACourse, Member as SQLAMember, CourseTags as SQLACourseTags, FavoriteCourse as SQLAFavoriteCourse, RecommendationLog as SQLARecommendationLog
from .schema import Course, Member, CourseTags, FavoriteCourse, RecommendationLog  # Pydantic 스키마 임포트
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


def load_data(db: Session, member_id: int, area: str):
    # 1. ORM으로 데이터 불러오기
    start = time.time()

    # 데이터 불러오기
    courses = get_courses(db, area)
    course_tags = get_course_tags(db)
    favorite_courses = get_favorite_courses(db, member_id)
    logs = get_recommendation_logs(db)  # 추천 로그 가져오기

    if not courses:
        return None

    # 코스 데이터 프레임 생성
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
        }
        for course in courses
    ]
    courses_df = pd.DataFrame.from_records(courses_data)

    # 코스 태그 데이터 프레임 생성
    course_tags_df = pd.DataFrame([{
        'course_id': tag.course_id,
        'tag_name': tag.tag_name
    } for tag in course_tags])

    # 즐겨찾기 코스 데이터 프레임 생성
    favorite_course_df = pd.DataFrame([{
        'member_id': fav.member_id,
        'tag_name': fav.tag_name
    } for fav in favorite_courses])

    # 실행 로그 불러오기
    logs_df = pd.DataFrame([{
        'log_id': log.log_id,
        'course_id': log.course_id,
        'member_id': log.member_id,
        'course_level': log.course_level,
        'average_slope': log.average_slope,
    } for log in logs])

    # 중복 로그 제거
    logs_df = logs_df.drop_duplicates(subset=['member_id', 'course_id'])

    # member_id가 logs_df에 있는지 확인
    if member_id in logs_df['member_id'].values:
        # member_id가 로그에 존재하는 경우, 로그와 즐겨찾기 태그 데이터 병합
        print(f"Found logs for user {member_id}. Generating recommendations based on logs and favorite courses...")

        # 코스와 태그 데이터 병합
        courses_with_tags_df = courses_df.merge(course_tags_df, on='course_id', how='left')

        # 로그와 즐겨찾기 데이터 병합
        logs_df = logs_df.merge(favorite_course_df[['member_id', 'tag_name']], on='member_id', how='left')

        # 사용자와 코스의 상호작용 행렬 생성
        interactions = coo_matrix((np.ones(len(logs_df)), (logs_df['member_id'], logs_df['course_id'])))

        model = LightFM(loss='logistic')

        try:
            print("Fitting the model...")
            model.fit(interactions, epochs=50, num_threads=2)
            print("Model training completed.")
        except Exception as e:
            print(f"Error during model training: {e}")

        # 추천 항목 가져오기
        user_id = member_id
        print(f"Generating recommendations for user {user_id}...")

        scores = model.predict(user_id, np.arange(interactions.shape[1]))
        scores = sigmoid(scores)

        # 추천 점수 추가
        top_items = courses_with_tags_df[
            courses_with_tags_df['course_id'].isin(np.arange(interactions.shape[1]))].copy().drop_duplicates(
            subset=['course_id'])
        top_items['추천 점수'] = scores[top_items['course_id'].values]
        top_items = top_items.sort_values(by='추천 점수', ascending=False).head(20)

    else:

        # member_id가 logs_df에 없는 경우 favorite_course만 사용하여 추천

        print(f"No logs found for user {member_id}. Recommending based on favorite courses...")

        # 사용자의 즐겨찾기 태그 가져오기

        favorite_tags = favorite_course_df[favorite_course_df['member_id'] == member_id]['tag_name'].unique()

        if len(favorite_tags) == 0:
            print(f"No favorite tags found for user {member_id}. Unable to generate recommendations.")

            return []

        # 코스와 태그 데이터 병합

        courses_with_tags_df = courses_df.merge(course_tags_df, on='course_id', how='left')


        # 사용자가 선호하는 태그에 해당하는 코스 필터링

        recommended_courses = courses_with_tags_df[courses_with_tags_df['tag_name'].isin(favorite_tags)]

        # 추천 코스가 없는 경우 처리

        if recommended_courses.empty:
            print(f"No courses found for the user's favorite tags: {favorite_tags}.")

            return []

        recommended_courses = recommended_courses.drop_duplicates(subset='course_id')

        # 추천 점수 계산 (단순하게 코스의 count를 기준으로 점수를 부여)

        recommended_courses['추천 점수'] = recommended_courses['count']  # count를 추천 점수로 사용

        # 상위 추천 코스 가져오기

        top_items = recommended_courses.sort_values(by='추천 점수', ascending=False).head(20)


    # PrettyTable 객체 생성
    table = PrettyTable()
    table.field_names = ["코스 ID", "이름", "레벨", "평균 경사", "주소", "참여자수", "코스 길이", "코스타입", "위도", "경도", "추천 점수"]

    # 상위 추천 및 점수 추가
    for index, row in top_items.iterrows():
        table.add_row([row['course_id'], row['name'], row['level'], row['average_slope'], row['address'], row['count'],
                       row['course_length'], row['course_type'], row['lat'], row['lng'], row['추천 점수']])

    # 출력
    print("추천 코스 (CF 기반):")
    print(table)

    recommendations = top_items[
        ['course_id', 'name', 'level', 'average_slope', 'address', 'count', 'course_length', 'course_type', 'lat',
         'lng', '추천 점수']].rename(
        columns={'course_id': 'courseId', 'average_slope': 'averageSlope', 'course_length': 'courseLength',
                 'course_type': 'courseType', '추천 점수': 'recommendationScore'}).to_dict(orient='records')
    end = time.time()
    print(f"{end - start:.5f} sec")
    return recommendations
