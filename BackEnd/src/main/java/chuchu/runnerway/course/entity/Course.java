package chuchu.runnerway.course.entity;

import chuchu.runnerway.course.dto.request.UserCourseRegistRequestDto;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.domain.MemberImage;
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
    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

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

    @OneToOne(mappedBy = "course", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private CourseImage courseImage;

    public void updateUserCourse(UserCourseRegistRequestDto userCourseRegistRequestDto, Member member) {
        this.name = userCourseRegistRequestDto.getName();                   // 코스명
        this.address = userCourseRegistRequestDto.getAddress();             // 코스 시작 주소
        this.content = userCourseRegistRequestDto.getContent();             // 코스 한 줄평
        this.member = member;
        this.level = userCourseRegistRequestDto.getLevel();                 // 코스 난이도
        this.averageSlope = userCourseRegistRequestDto.getAverageSlope();   // 평균 경사도
        this.averageDownhill = userCourseRegistRequestDto.getAverageDownhill(); // 평균 내리막도
        this.averageTime = userCourseRegistRequestDto.getAverageTime();     // 예상 평균 소요 시간
        this.courseLength = userCourseRegistRequestDto.getCourseLength();   // 코스 전체 길이
        this.courseType = userCourseRegistRequestDto.getCourseType();       // 코스 타입
        this.averageCalorie = userCourseRegistRequestDto.getAverageCalorie(); // 예상 평균 소모 칼로리
        this.lat = userCourseRegistRequestDto.getLat();                     // 위도
        this.lng = userCourseRegistRequestDto.getLng();                     // 경도
    }
}
