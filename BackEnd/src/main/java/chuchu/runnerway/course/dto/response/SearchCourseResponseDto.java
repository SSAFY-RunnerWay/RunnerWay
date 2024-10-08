package chuchu.runnerway.course.dto.response;

import chuchu.runnerway.course.entity.CourseType;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@AllArgsConstructor
@Getter
@Setter
@EqualsAndHashCode
public class SearchCourseResponseDto {
    private Long courseId;
    private String name;
    private String address;
    private String content;
    private Long count;
    private Integer level;
    private Integer averageSlope;
    private Integer averageDownhill;
    private LocalDateTime averageTime;
    private double courseLength;
    private Long memberId;
    private String memberNickname;
    private CourseType courseType;
    private LocalDateTime registDate;
    private double averageCalorie;
    private double lat;
    private double lng;
    private String url;
}
