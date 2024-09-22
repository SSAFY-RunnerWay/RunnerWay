package chuchu.runnerway.course.dto.response;

import chuchu.runnerway.course.dto.CourseImageDto;
import chuchu.runnerway.course.entity.CourseType;
import lombok.Data;
import lombok.Getter;

import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@Data
public class OfficialDetailResponseDto {
    private Long courseId;

    private String name;
    private String address;
    private String content;
    private Long count;
    private int level;
    private int averageSlope;
    private LocalDateTime averageTime;
    private double courseLength;
    private double averageCalorie;
    private CourseType courseType;
    private double lat;
    private double lng;
    private CourseImageDto courseImage;


}
