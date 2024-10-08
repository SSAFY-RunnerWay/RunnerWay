package chuchu.runnerway.course.dto.response;

import chuchu.runnerway.course.dto.CourseImageDto;
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
    private CourseImageDto courseImage;

    public SearchCourseResponseDto(Long courseId, String name, String address, String content, Long count, Integer level, Integer averageSlope, Integer averageDownhill, LocalDateTime averageTime, double courseLength, Long memberId, String memberNickname, CourseType courseType, LocalDateTime registDate, double averageCalorie, double lat, double lng) {
        this.courseId = courseId;
        this.name = name;
        this.address = address;
        this.content = content;
        this.count = count;
        this.level = level;
        this.averageSlope = averageSlope;
        this.averageDownhill = averageDownhill;
        this.averageTime = averageTime;
        this.courseLength = courseLength;
        this.memberId = memberId;
        this.memberNickname = memberNickname;
        this.courseType = courseType;
        this.registDate = registDate;
        this.averageCalorie = averageCalorie;
        this.lat = lat;
        this.lng = lng;
    }
}
