package chuchu.runnerway.course.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.DateFormat;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import java.time.LocalDateTime;

@Document(indexName = "elasticsearchcourse")
@Getter
@Builder
@AllArgsConstructor
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
    private Integer averageDownhill;

    @Field(type = FieldType.Date, name = "average_time", format = DateFormat.date_hour_minute_second)
    private LocalDateTime averageTime;

    @Field(type = FieldType.Double, name = "course_length")
    private double courseLength;

    // 코스 작성자
    @Field(type = FieldType.Long, name = "member_id")
    private Long memberId;

    // 코스 작성자 닉네임
    @Field(type = FieldType.Text, name = "member_nickname")
    private String memberNickname;

    @Field(type = FieldType.Keyword, name = "course_type")
    private CourseType courseType;

    @Field(type = FieldType.Date, name = "regist_date", format = DateFormat.date_hour_minute_second)
    private LocalDateTime registDate;

    @Field(type = FieldType.Double, name = "average_calorie")
    private double averageCalorie;

    @Field(type = FieldType.Double, name = "lat")
    private double lat;

    @Field(type = FieldType.Double, name = "lng")
    private double lng;
}
