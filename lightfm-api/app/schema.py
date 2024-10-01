from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime, time

# Course 스키마
class CourseBase(BaseModel):
    name: str
    address: str
    content: str
    count: int = 0
    level: int
    average_slope: int
    average_downhill: int
    average_time: Optional[time]
    course_length: float
    member_id: int
    course_type: str  # CourseType Enum을 문자열로 정의
    regist_date: datetime
    average_calorie: float
    lat: float
    lng: float
    area: str

class Course(CourseBase):
    course_id: int
    lat: float  # string으로 수정
    lng: float
    tags: List[str] = []  # CourseTags의 이름을 리스트로 포함할 수 있습니다.

    class Config:
        orm_mode = True
        from_attributes = True

class CourseImageBase(BaseModel):
    url: str
    path: str

class CourseImage(CourseImageBase):
    course_id: int

    class Config:
        orm_mode = True
        from_attributes = True


# Member 스키마
class MemberBase(BaseModel):
    email: str
    join_type: str  # 'kakao' 또는 'google'
    nickname: str
    birth: Optional[datetime] = None
    height: Optional[int] = None
    weight: Optional[int] = None
    create_time: datetime
    resign_time: Optional[datetime] = None
    is_resign: bool = False

class Member(MemberBase):
    member_id: int
    # courses: List[Course] = []  # 해당 멤버가 작성한 코스를 포함합니다.

    class Config:
        orm_mode = True
        from_attributes = True


# CourseTags 스키마
class CourseTagsBase(BaseModel):
    course_id: int
    tag_name: str

class CourseTags(CourseTagsBase):
    tag_id: int
    tag_name: str
    class Config:
        orm_mode = True
        from_attributes = True


# FavoriteCourse 스키마
class FavoriteCourseBase(BaseModel):
    member_id: int
    tag_name: str

class FavoriteCourse(FavoriteCourseBase):
    favorite_course_id: int

    class Config:
        orm_mode = True
        from_attributes = True

class RecommendationLogBase(BaseModel):
    course_id: int
    member_id: int
    course_level: int
    average_slope: int

class RecommendationLog(RecommendationLogBase):
    log_id: int

    class Config:
        orm_mode = True
        from_attributes = True