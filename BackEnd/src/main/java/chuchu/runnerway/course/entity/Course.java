package chuchu.runnerway.course.entity;

import chuchu.runnerway.course.dto.request.UserCourseRegistRequestDto;
import chuchu.runnerway.member.domain.Member;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
public class Course {

    public Course() {
    }

    @Builder
    public Course(Long courseId, CourseImage courseImage, String name, String address, String content, Long count, int level, int averageSlope, int averageDownhill, LocalDateTime averageTime, double courseLength, CourseType courseType, LocalDateTime registDate, double averageCalorie, double lat, double lng, Member member) {
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
        this.member = member;
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
    private LocalDateTime averageTime;

    @Column(name = "course_length")
    private double courseLength;

    @Column(name = "courseType", nullable = false)
    @Enumerated(EnumType.STRING)
    private CourseType courseType;

    @Column(name = "regist_date")
    @CreationTimestamp
    private LocalDateTime registDate;

    @Column(name = "average_calorie", nullable = false)
    private double averageCalorie;

    @Column(name = "lat", nullable = false)
    private double lat;

    @Column(name = "lng", nullable = false)
    private double lng;

    @OneToOne(mappedBy = "course", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JsonManagedReference
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
