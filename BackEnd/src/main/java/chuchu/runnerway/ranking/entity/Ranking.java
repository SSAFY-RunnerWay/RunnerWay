package chuchu.runnerway.ranking.entity;

import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.member.domain.Member;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import org.hibernate.annotations.ColumnDefault;

import java.time.LocalTime;

@Entity
@Getter
public class Ranking {

    public Ranking() {
    }

    @Builder
    public Ranking(Long rankId, Member member, Course course, LocalTime score, String path) {
        this.rankId = rankId;
        this.member = member;
        this.course = course;
        this.score = score;
        this.path = path;
        this.isDelete = false;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "rank_id")
    private Long rankId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id")
    private Course course;

    @Column(name = "score", nullable = false)
    private LocalTime score;

    @Column(name = "path",  nullable = false)
    private String path;

    @Column(name = "is_delete", columnDefinition = "TINYINT(1)")
    @ColumnDefault("false")
    private Boolean isDelete;

    public void createRanking(Course course, Member member, LocalTime score, String path){
        this.course = course;
        this.member = member;
        this.score = score;
        this.path = path;
        this.isDelete = false;
    }

    public void deleteRanking(){
        this.isDelete = true;
    }

}
