package chuchu.runnerway.course.entity;

import jakarta.persistence.*;
import lombok.Getter;

@Entity
@Getter
public class CourseImage {

    @Id
    @Column(name = "course_id")
    private Long courseId;

    @OneToOne(mappedBy = "courseImage", fetch = FetchType.LAZY)
    private Course course;

    @Column(name = "url")
    private String url;

    @Column(name = "path")
    private String path;

}
