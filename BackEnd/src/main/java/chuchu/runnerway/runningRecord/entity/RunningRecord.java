package chuchu.runnerway.runningRecord.entity;

import chuchu.runnerway.course.entity.Course;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;

import java.sql.Time;
import java.sql.Timestamp;

@Entity
@Getter
public class RunningRecord {

    public RunningRecord() {
    }

    @Builder
    public RunningRecord(Long recordId, PersonalImage personalImage, Course course, Time score, double runningDistance, double calorie, double averageFace, String comment, Timestamp startDate, Timestamp finishDate) {
        this.recordId = recordId;
        this.personalImage = personalImage;
        this.course = course;
        this.score = score;
        this.runningDistance = runningDistance;
        this.calorie = calorie;
        this.averageFace = averageFace;
        this.comment = comment;
        this.startDate = startDate;
        this.finishDate = finishDate;
    }




    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "record_id", nullable = false)
    private Long recordId;

    // 멤버 객체 추가 해야함

    @OneToOne(mappedBy = "runningRecord", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private PersonalImage personalImage;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id")
    private Course course;

    @Column(name = "score", nullable = false)
    private Time score;

    @Column(name = "running_distance", nullable = false)
    private double runningDistance;

    @Column(name = "calorie", nullable = false)
    private double calorie;

    @Column(name = "average_face", nullable = false)
    private double averageFace;

    @Column(name = "comment", length = 500)
    private String comment;

    @Column(name = "start_date", nullable = false)
    private Timestamp startDate;
    @Column(name = "finish_date", nullable = false)
    private Timestamp finishDate;
}
