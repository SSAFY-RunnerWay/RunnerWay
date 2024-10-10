package chuchu.runnerway.course.model.repository;

import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.entity.CourseImage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CourseImageRepository extends JpaRepository<CourseImage, Course> {

}
