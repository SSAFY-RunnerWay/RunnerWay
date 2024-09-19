package chuchu.runnerway.course.dto.request;

import chuchu.runnerway.course.dto.CourseImageDto;
import chuchu.runnerway.course.entity.CourseType;
import java.sql.Time;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class UserCourseRegistRequestDto {
    private String name;                    //코스명
    private String address;                 //코스 시작 주소
    private String content;                 //코스 한 줄평
    private Long memberId;                  //코스 작성자
    private int level;                      //코스 난이도
    private int averageSlope;               //평균 경사도
    private int averageDownhill;            //평균 내리막도
    private LocalDateTime averageTime;               //예상 평균 소요 시간
    private double courseLength;            //코스 전체 길이
    private CourseType courseType;          //코스 타입
    private double averageCalorie;          //예상 평균 소모 칼로리
    private String lat;                     //위도
    private String lng;                     //경도
    private CourseImageDto courseImage;     //코스이미지
}
