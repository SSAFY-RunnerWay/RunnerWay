from pyproj import Transformer
import rasterio
from math import radians, sin, cos, sqrt, atan2
from pydantic import BaseModel

# .img 파일 열기
# img_file = '36710.img'  # 실제 .img 파일 경로
# dataset = rasterio.open(img_file)

# 좌표 변환기 설정: EPSG:4326 (위도/경도) -> EPSG:5179 (Korea 2000 Unified Coordinate System)
transformer = Transformer.from_crs("EPSG:4326", "EPSG:5179", always_xy=True)

class SlopeData(BaseModel):
    averageSlope: int = 0
    averageDownhill: int = 0

# 좌표 변환 함수 (위도/경도 -> EPSG:5179)
def transform_coordinates(lat, lon):
    return transformer.transform(lon, lat)



# 각 지점에서 고도 추출 함수
def get_elevation(lon, lat, dataset):
    try:
        # UTM 좌표를 픽셀 좌표로 변환
        row, col = dataset.index(lon, lat)

        # 인덱스가 유효한지 확인 (배열 크기 내에 있는지 확인)
        if 0 <= row < dataset.height and 0 <= col < dataset.width:
            return dataset.read(1)[int(row), int(col)]
        else:
            print(f"좌표가 데이터 범위를 벗어났습니다: ({lon}, {lat})")
            return None
    except Exception as e:
        print(f"좌표 변환 오류: {e}")
        return None


def make_elevation(dataset, utm_paths):
    # 고도 데이터 추출
    elevations = []
    for lon, lat in utm_paths:
        elevation = get_elevation(lon, lat, dataset)
        if elevation is not None:
            elevations.append(elevation)

    print(f"경로의 고도 데이터: {elevations}")
    return elevations



# 하버사인 공식을 사용하여 거리 계산 함수
def haversine(lon1, lat1, lon2, lat2):
    R = 6371000  # 지구 반지름 (미터)
    phi1, phi2 = radians(lat1), radians(lat2)
    delta_phi = radians(lat2 - lat1)
    delta_lambda = radians(lon2 - lon1)
    a = sin(delta_phi / 2) ** 2 + cos(phi1) * cos(phi2) * sin(delta_lambda / 2) ** 2
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    distance = R * c
    return distance


# 경사도 및 내리막도 계산
def calculate_slope(paths, dataset):
    utm_paths = [transform_coordinates(lat, lon) for lon, lat in paths]
    elevations = make_elevation(dataset, utm_paths)
    slopes = []
    downhill_slopes = []
    total_distance = 0  # 총 거리를 계산하기 위한 변수
    for i in range(1, len(elevations)):
        height_diff = elevations[i] - elevations[i - 1]
        lon1, lat1 = paths[i - 1]
        lon2, lat2 = paths[i]
        distance = haversine(lon1, lat1, lon2, lat2)

        # 총 거리 계산
        total_distance += distance

        # 경사도 계산
        slope_percent = (height_diff / distance) * 100 if distance != 0 else 0
        slopes.append(slope_percent)

        # 내리막도 계산 (내리막인 경우)
        if height_diff < 0:
            downhill_slopes.append(abs(slope_percent))

        # 각 구간 거리 및 경사도 출력
        print(f"지점 {i + 1}에서 {i + 2}까지의 거리: {distance:.2f} meters, 경사도: {slope_percent:.2f}%")

    slope_data = SlopeData()
    # 평균 경사도 및 평균 내리막도 계산
    if slopes:
        avg_slope = sum(slopes) / len(slopes)
        if(avg_slope < 0):
            slope_data.averageSlope = 0
        else:
            slope_data.averageSlope = round(avg_slope)
        print(f"\n총 거리: {total_distance:.2f} meters")
        print(f"평균 경사도: {avg_slope:.2f}%")

    if downhill_slopes:
        avg_downhill_slope = sum(downhill_slopes) / len(downhill_slopes)
        slope_data.averageDownhill = round(avg_downhill_slope)
        print(f"평균 내리막도: {avg_downhill_slope:.2f}%")
    else:
        slope_data.averageDownhill = 0.0
        print("내리막 구간이 없습니다.")

    return slope_data