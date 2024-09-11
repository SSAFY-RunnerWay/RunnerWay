package chuchu.runnerway.course.model.repository;

import chuchu.runnerway.course.entity.Course;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserCourseRepository extends JpaRepository<Course, Long> {

    @Query(value = "SELECT * FROM course c " +
            "WHERE (6371 * acos(cos(radians(:lat)) * cos(radians(c.lat)) * " +
            "cos(radians(c.lng) - radians(:lng)) + sin(radians(:lat)) * sin(radians(c.lat)))) <= 3 " +
            "AND c.course_type = 'user'",
            nativeQuery = true)
    List<Course> findAll(@Param("lat") double lat, @Param("lng") double lng);
}
