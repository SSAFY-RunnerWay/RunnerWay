package chuchu.runnerway.course.entity;

import lombok.Builder;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import java.sql.Time;
import java.sql.Timestamp;

@Document(indexName = "elasticsearchcourse")
@Getter
@Builder
public class ElasticSearchCourse {
    @Id
    private Long courseId;

    @Field(type = FieldType.Text, name = "name")
    private String name;

    @Field(type = FieldType.Text, name = "address")
    private String address;

    @Field(type = FieldType.Text, name = "content")
    private String content;

    @Field(type = FieldType.Long, name = "count")
    private Long count;

    @Field(type = FieldType.Integer, name = "level")
    private Integer level;

    @Field(type = FieldType.Integer, name = "average_slope")
    private Integer averageSlope;

    @Field(type = FieldType.Integer, name = "average_downhill")
    private int averageDownhill;

    @Field(type = FieldType.Date, name = "average_time")
    private Time averageTime;

    @Field(type = FieldType.Double, name = "course_length")
    private double courseLength;

    // 코스 작성자
    @Field(type = FieldType.Long, name = "memberId")
    private Long memberId;

    @Field(type = FieldType.Keyword, name = "courseType")
    private String courseType;

    @Field(type = FieldType.Date, name = "regist_date")
    private Timestamp registDate;

    @Field(type = FieldType.Double, name = "average_calorie")
    private double averageCalorie;

    @Field(type = FieldType.Text, name = "lat")
    private String lat;

    @Field(type = FieldType.Text, name = "lng")
    private String lng;
}
