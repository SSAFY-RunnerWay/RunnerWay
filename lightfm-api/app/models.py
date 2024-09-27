from sqlalchemy import Column, Integer, String, ForeignKey, BigInteger, Time, Float, DateTime, Boolean, TIMESTAMP, Date
from sqlalchemy.orm import relationship
from sqlalchemy import Enum as SQLAEnum  # SQLAlchemy의 Enum
from enum import Enum  # Python의 Enum을 임포트
from . import Base  # Base는 데이터베이스에서 가져옵니다.

class CourseType(str, Enum):
    official = 'official'
    user = 'user'

class JoinType(str, Enum):  # 새로운 JoinType Enum 정의
    kakao = 'kakao'
    google = 'google'

class Course(Base):
    __tablename__ = "course"  # 테이블 이름을 정의합니다.

    course_id = Column(BigInteger, primary_key=True, index=True)  # AI PK
    name = Column(String(255), nullable=False)  # 코스 이름
    address = Column(String(255), nullable=False)  # 주소
    content = Column(String(500), nullable=False)  # 내용
    count = Column(BigInteger, default=0)  # 사용자 수
    level = Column(Integer, nullable=False)  # 난이도
    average_slope = Column(Integer, nullable=False)  # 평균 경사
    average_downhill = Column(Integer, nullable=False)  # 평균 하강
    average_time = Column(Time, nullable=False)  # 평균 시간
    course_length = Column(Float, nullable=False)  # 코스 길이
    member_id = Column(BigInteger, ForeignKey("member.member_id"), nullable=False)  # 외래키로 member_id 설정
    course_type = Column(SQLAEnum(CourseType), nullable=False)  # 코스 타입
    
    regist_date = Column(DateTime, nullable=False)  # 등록일
    average_calorie = Column(Float, nullable=False)  # 평균 칼로리
    lat = Column(Float, nullable=False)  # 위도
    lng = Column(Float, nullable=False)  # 경도
    area = Column(String(45), nullable=False)

    # Member와의 관계 설정
    member = relationship("Member", back_populates="courses")
    
    # CourseTags와의 관계 설정
    tags = relationship("CourseTags", back_populates="course")

    # 1:1 관계 설정
    course_image = relationship("CourseImage", back_populates="course", uselist=False)

class CourseImage(Base):
    __tablename__ = "course_image"

    course_id = Column(BigInteger, ForeignKey('course.course_id'), primary_key=True)
    url = Column(String(255), nullable=False)
    path = Column(String(255), nullable=False)

    course = relationship("Course", back_populates="course_image")

class Member(Base):
    __tablename__ = "member"  # 테이블 이름을 정의합니다.

    member_id = Column(BigInteger, primary_key=True, index=True)  # AI PK
    email = Column(String(255), nullable=False)  # 이메일
    join_type = Column(SQLAEnum(JoinType), nullable=False)  # 가입 유형으로 JoinType 사용
    nickname = Column(String(30), nullable=False)  # 닉네임
    birth = Column(Date, nullable=True)  # 생년월일
    height = Column(Integer, nullable=True)  # 키
    weight = Column(Integer, nullable=True)  # 몸무게
    create_time = Column(TIMESTAMP, nullable=False)  # 가입 시간
    resign_time = Column(TIMESTAMP, nullable=True)  # 퇴사 시간
    is_resign = Column(Boolean, default=False)  # 퇴사 여부

    # Course와의 관계 설정 (예시로 추가)
    courses = relationship("Course", back_populates="member")

    favorite_courses = relationship("FavoriteCourse", back_populates="member")

class CourseTags(Base):
    __tablename__ = "course_tags"  # 테이블 이름을 정의합니다.

    tag_id = Column(BigInteger, primary_key=True, index=True)  # AI PK
    course_id = Column(BigInteger, ForeignKey("course.course_id"), nullable=False)  # 외래키로 course_id를 설정
    tag_name = Column(String(255), nullable=False)  # 태그 이름

    # Course와의 관계 설정
    course = relationship("Course", back_populates="tags")


class FavoriteCourse(Base):
    __tablename__ = "favorite_course"

    favorite_course_id = Column(BigInteger, primary_key=True, index=True)  # 기본 키
    member_id = Column(BigInteger, ForeignKey("member.member_id"), nullable=False)  # Member 테이블의 외래키
    tag_name = Column(String(255), nullable=False)  # 태그 이름

    member = relationship("Member", back_populates="favorite_courses")
