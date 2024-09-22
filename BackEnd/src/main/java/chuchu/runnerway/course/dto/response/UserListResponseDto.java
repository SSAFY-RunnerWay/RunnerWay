package chuchu.runnerway.course.dto.response;

import chuchu.runnerway.course.dto.CourseImageDto;
import chuchu.runnerway.course.entity.CourseType;
import lombok.Data;

@Data
public class UserListResponseDto {
    private Long courseId;
    private String name;
    private String address;
    private Long count;
    private int level;
    private double courseLength;
    private double distance;
    private CourseType courseType;
    private CourseImageDto courseImage;
    private String nickname;
}
