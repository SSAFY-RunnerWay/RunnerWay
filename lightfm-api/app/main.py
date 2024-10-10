from fastapi import FastAPI, HTTPException, Depends, Query
from sqlalchemy.orm import Session
from .crud import get_db, load_running_logs, get_favorite_courses, get_courses, get_course_tags, get_members
from .models import Course as SQLACourse, Member as SQLAMember, CourseTags as SQLACourseTags, FavoriteCourse as SQLAFavoriteCourse, RecommendationLog as SQLARecommendationLog
from .schema import Course, Member, CourseTags, FavoriteCourse, RecommendationLog  # Pydantic 스키마 임포트
from .slope import calculate_slope
from.train_model import load_data
from botocore.exceptions import NoCredentialsError
from io import BytesIO
import pandas as pd  # 데이터프레임 처리
import rasterio
import os
import sys
import boto3
import httpx
import json
print("sys.path: ", sys.path)

app = FastAPI()

@app.get("/recommendation")
def getCourses(
    member_id: int = Query(...), 
    area: str = Query(...),
    db: Session = Depends(get_db)
):
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))
    data = load_data(db, member_id, area)
    return data


@app.get("/slope")
async def getSlope(S3_URL: str = Query(...)):
    print(S3_URL)
    current_dir = os.path.dirname(os.path.abspath(__file__))
    img_file = os.path.join(current_dir, '36710.img')
    dataset = rasterio.open(img_file)
    print("dataset: ", dataset.meta)
    paths = [];
    try:
        async with httpx.AsyncClient() as client:
            response = await client.get(S3_URL)
            response.raise_for_status()  # 요청 실패 시 예외 발생
            json_data = response.json()
            print(json_data)
            paths = [[item["longitude"], item["latitude"]] for item in json_data]
            print(paths)
    except Exception as e:
        return {"error": "파일을 가져오는 데 실패했습니다: " + str(e)}

    slope_data = calculate_slope(paths, dataset)
    return slope_data