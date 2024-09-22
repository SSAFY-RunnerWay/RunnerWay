package chuchu.runnerway.course.dto.response;

import chuchu.runnerway.course.dto.CourseImageDto;
import chuchu.runnerway.course.entity.CourseType;
import lombok.Data;
import lombok.Getter;

import java.sql.Time;

@Data
public class OfficialListResponseDto {
    private Long courseId;
    private String name;
    private String address;
    private Long count;
    private int level;
    private double courseLength;
    private CourseType courseType;
    private CourseImageDto courseImage;

}
