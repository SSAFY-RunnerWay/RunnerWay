package chuchu.runnerway.course.entity;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;

import java.sql.Time;
import java.sql.Timestamp;

@Entity
@Getter
public class Course {

    public Course() {
    }

    @Builder
    public Course(Long courseId, CourseImage courseImage, String name, String address, String content, Long count, int level, int averageSlope, int averageDownhill, Time averageTime, double courseLength, CourseType courseType, Timestamp registDate, double averageCalorie, String lat, String lng) {
        this.courseId = courseId;
        this.courseImage = courseImage;
        this.name = name;
        this.address = address;
        this.content = content;
        this.count = count;
        this.level = level;
        this.averageSlope = averageSlope;
        this.averageDownhill = averageDownhill;
        this.averageTime = averageTime;
        this.courseLength = courseLength;
        this.courseType = courseType;
        this.registDate = registDate;
        this.averageCalorie = averageCalorie;
        this.lat = lat;
        this.lng = lng;
    }

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "course_id")
    private Long courseId;

    // Member가 생기면 Member 넣어주기

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id")
    private CourseImage courseImage;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "content", length = 500)
    private String content;

    @Column(name = "count")
    @ColumnDefault("0")
    private Long count;

    @Column(name = "level")
    private int level;

    @Column(name = "average_slope")
    private int averageSlope;

    @Column(name = "average_downhill")
    private int averageDownhill;

    @Column(name = "average_time")
    private Time averageTime;

    @Column(name = "course_length")
    private double courseLength;

    @Column(name = "courseType", nullable = false)
    @Enumerated(EnumType.STRING)
    private CourseType courseType;

    @Column(name = "regist_date")
    @CreationTimestamp
    private Timestamp registDate;

    @Column(name = "average_calorie", nullable = false)
    private double averageCalorie;

    @Column(name = "lat", nullable = false)
    private String lat;

    @Column(name = "lng", nullable = false)
    private String lng;
}
