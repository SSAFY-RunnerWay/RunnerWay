package chuchu.runnerway.runningRecord.entity;

import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.member.domain.Member;
import jakarta.persistence.*;
import lombok.Getter;

@Entity
@Getter
public class RecommendationLog {

    public RecommendationLog() {
    }

    public RecommendationLog(Course courseId, Member memberId, int courseLevel, int averageSlope) {
        this.course = courseId;
        this.member = memberId;
        this.courseLevel = courseLevel;
        this.averageSlope = averageSlope;
    }

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long logId;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id")
    private Course course;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;


    @Column(name = "course_level")
    private int courseLevel;
    @Column(name = "average_slope")
    private int averageSlope;

}
