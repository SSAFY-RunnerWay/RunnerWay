package chuchu.runnerway.course.entity;

import static jakarta.persistence.FetchType.LAZY;

import chuchu.runnerway.course.dto.CourseImageDto;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name = "course_image")
@Builder
@DynamicInsert
@DynamicUpdate
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class CourseImage {

    @Id
    @Column(name = "course_id")
    private Long courseId;

    @OneToOne(optional = false, fetch = LAZY)
    @MapsId
    @JoinColumn(name = "course_id")
    @JsonBackReference
    private Course course;

    @Column(name = "url")
    private String url;

    @Column(name = "path")
    private String path;
}
