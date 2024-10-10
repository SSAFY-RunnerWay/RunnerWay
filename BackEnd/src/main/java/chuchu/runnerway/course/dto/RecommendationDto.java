package chuchu.runnerway.course.dto;

import chuchu.runnerway.course.entity.CourseType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RecommendationDto {
    private Long courseId;
    private String name;
    private String address;
    private Long count;
    private int level;
    private double courseLength;
    private CourseType courseType;
    private double lat;
    private double lng;
    private CourseImageDto courseImage;

    @Override
    public String toString() {
        return "RecommendationDto{" +
                "courseId=" + courseId +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", count=" + count +
                ", level=" + level +
                ", courseLength=" + courseLength +
                ", courseType=" + courseType +
                ", lat=" + lat +
                ", lng=" + lng +
                ", courseImage=" + courseImage +
                '}';
    }
}
