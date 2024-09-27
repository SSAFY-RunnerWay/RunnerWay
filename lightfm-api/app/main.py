from fastapi import FastAPI, HTTPException, Depends, Query
from sqlalchemy.orm import Session
from .crud import get_db, load_running_logs, get_favorite_courses, get_courses, get_course_tags, get_members
from .models import Course as SQLACourse, Member as SQLAMember, CourseTags as SQLACourseTags, FavoriteCourse as SQLAFavoriteCourse
from .schema import Course, Member, CourseTags, FavoriteCourse  # Pydantic 스키마 임포트
from.train_model import load_data
import pandas as pd  # 데이터프레임 처리
import os


app = FastAPI()

@app.get("/recommendation")
def getCourses(
    member_id: int = Query(...), 
    area: str = Query(...),
    db: Session = Depends(get_db)
):
    # log_path = "C:/Users/SSAFY/Desktop/Project/runnerway/lightFM/lightfm-api/app/running_logs4.csv"
    # log_path = "./running_logs4.csv"
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))
    log_path = os.path.join(BASE_DIR, "running_logs4.csv")
    data = load_data(db, log_path, member_id, area)
    return data