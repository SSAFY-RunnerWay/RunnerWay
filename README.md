
# 프로젝트명 (Runner Way)

## 프로젝트 개요

이 프로젝트는 사용자가 기록한 러닝 데이터를 바탕으로 맞춤형 코스 추천 및 경로 시각화를 제공하는 시스템입니다. 각 사용자별로 달리기, 산책, 자전거 코스 등을 추천하고, 경로의 경사도를 분석하여 사용자에게 최적의 운동 경험을 제공합니다.

## 주요 기능

- **경로 추천**: 사용자 기록을 기반으로 유사한 코스를 찾아 추천
- **경로 시각화**: 지도 상에서 경로를 시각화하고 경사도와 함께 표시
- **경사도 분석**: DEM 데이터를 사용해 경사도 계산 및 내리막 경사도 계산 및 코스 난이도화
- **사용자 기록 관리**: 사용자의 운동 기록(거리, 칼로리, 경과 시간 등)을 저장 및 분석
- **대결 모드**: 랭커 혹은 나와의 대결 모드

## 기술 고도화

- 캐시 사용
    - real-time에 대해서 반복적인 update 발생
        - redis(cache)의 key-value를 이용하여 real-time(참여자 수) update를 하고 특정 기간 (24시간)마다 데이터베이스(mysql) 반영
    - 가변성이 적은 data 조회
        - 자주 변화하지 않는 data에 대해서 redis(cache)에 저장 후 조회 시 성능 향상
- 추천 알고리즘
    - data 부족 시 CBF, 충분한 data가 쌓여 있을 시 CF알고리즘 이용하여 하이브리드 필터 적용 추천
    - Python LightFm 라이브러리 사용

![image.png](/Image/image.png)

- 경사도 계산 알고리즘
    - 국토지리정보원에서 제공하는 DEM(국도 이미지) 이용하여 고도를 불러오고 고도를 이용하여 경사도 계산
    - FastApi 사용
    
    ![image.png](/Image/image%201.png)
    
- GPS기반 주변 러닝 코스 목록 조회
    - 매번 움직일 때 마다 조회하는 것은 DB에 부담이 큼
    - 갱신하는 버튼을 추가해서 갱신
    - 조회 시 H3 라이브러리 사용 혹은 구역을 미리 지정 후 구역별 조회

## 개발 현황

- API 개발 90% 완료

![image.png](/Image/image%202.png)

- 배포 현황
    - 배포 완료
    - [https://j11b304.p.ssafy.io/api/secret/swagger-of-chuchu/swagger-ui/index.html](https://j11b304.p.ssafy.io/api/secret/swagger-of-chuchu/swagger-ui/index.html)

![image.png](/Image/image%203.png)

- flutter 현황
    
    하단 바 개발 완료 및 gps 경로 그리기 완료
    
    ![runnerwaygif.gif](/Image/runnerwaygif.gif)
    

## 추후 개발 현황

- 추천 알고리즘 구현
- 검색 로직 (Elastic Search) 구현
- 유사도 알고리즘 개발
- Front 개발 및 apk 추출
- Front - Back 연결
