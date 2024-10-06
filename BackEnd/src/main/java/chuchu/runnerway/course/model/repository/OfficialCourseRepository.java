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

    @Query(value = "SELECT c FROM Course c " +
            "WHERE c.courseId NOT IN :existCourseId AND c.area = :area ORDER BY RAND() LIMIT :neededCount")
    List<Course> findCourse(@Param("neededCount") int neededCount, @Param("existCourseId") List<Long> existCourseId, @Param("area") String area);

    List<Course> findByCourseIdNot(Long courseId);

    Optional<Course> findByCourseId(Long courseId);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Course c SET c.area = :h3Index " +
            "WHERE c.courseId = :courseId")
    void updateArea(Long courseId, String h3Index);


}
