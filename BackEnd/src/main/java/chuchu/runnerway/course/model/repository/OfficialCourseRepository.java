package chuchu.runnerway.course.model.repository;

import chuchu.runnerway.course.entity.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

public interface OfficialCourseRepository extends JpaRepository<Course, Long> {

    @Query(value = "SELECT * FROM course c " +
            "WHERE (6371 * acos(cos(radians(:lat)) * cos(radians(c.lat)) * " +
            "cos(radians(c.lng) - radians(:lng)) + sin(radians(:lat)) * sin(radians(c.lat)))) <= 3 " +
            "and c.course_type = 'official'",
            nativeQuery = true)
    List<Course> findAll(@Param("lat") double lat, @Param("lng") double lng);

    List<Course> findByCourseIdNot(Long courseId);

    Optional<Course> findByCourseId(Long courseId);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Course c SET c.area = :h3Index " +
            "WHERE c.courseId = :courseId")
    void updateArea(Long courseId, String h3Index);

}
