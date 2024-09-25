from sqlalchemy.orm import Session
from sqlalchemy import func
from .models import Course, Member, CourseTags, FavoriteCourse, CourseImage
from . import SessionLocal  # 데이터베이스 세션을 가져오는 경우


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def load_running_logs(filepath: str):
    import pandas as pd
    logs_df = pd.read_csv(filepath)
    logs_df = logs_df.drop_duplicates(subset=['member_id', 'course_id'])

    # course_id를 인덱스로 변환
    logs_df['course_id'] = logs_df['course_id'].astype('category').cat.codes
    return logs_df

def get_favorite_courses(db: Session, member_id: int):
    favorite_courses = db.query(FavoriteCourse).filter(FavoriteCourse.member_id == member_id).all()
    return favorite_courses


def get_courses(db: Session, lat: float, lng: float):
    courses = db.query(Course).filter(Course.course_id != 0,
    (6371 * func.acos(
        func.cos(func.radians(lat)) * func.cos(func.radians(Course.lat)) *
        func.cos(func.radians(Course.lng) - func.radians(lng)) +
        func.sin(func.radians(lat)) * func.sin(func.radians(Course.lat))
    )) <= 3,
    Course.course_type == 'official').all()
    # courses = db.query(Course, CourseImage).outerjoin(CourseImage, Course.course_id == CourseImage.course_id).filter(Course.course_id != 0,
    # (6371 * func.acos(
    #     func.cos(func.radians(lat)) * func.cos(func.radians(Course.lat)) *
    #     func.cos(func.radians(Course.lng) - func.radians(lng)) +
    #     func.sin(func.radians(lat)) * func.sin(func.radians(Course.lat))
    # )) <= 3,
    # Course.course_type == 'official').all()
    return courses


def get_course_tags(db: Session):
    course_tags = db.query(CourseTags).all()
    return course_tags

def get_members(db: Session):
    members = db.query(Member).all()
    return members

# Example of using the CRUD functions
def main(filepath: str):
    with get_db() as db:  # Using the context manager to manage the session
        running_logs = load_running_logs(filepath)
        favorite_courses = get_favorite_courses(db)
        courses = get_courses(db)
        course_tags = get_course_tags(db)
        members = get_members(db)

        # Here you can do further processing with the loaded data

    

if __name__ == "__main__":
    main("running_logs.csv")
