package chuchu.runnerway.course.model.repository;

import chuchu.runnerway.course.entity.Course;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserCourseRepository extends JpaRepository<Course, Long> {


    @Query(value = "SELECT * FROM course c " +
            "WHERE c.area = :area " +
            "AND c.course_type = 'user'",
            nativeQuery = true)
    List<Course> findAll(@Param("area") String area);


    @Query(value = "SELECT * FROM course c " +
        "WHERE c.area = :area " +
        "AND c.course_type = 'user' " +
        "ORDER BY c.count DESC " +
        "LIMIT 3",
        nativeQuery = true)
    List<Course> findPopularAll(@Param("area") String area);


    @Query(value = "SELECT * FROM course c " +
        "WHERE c.area = :area " +
        "AND c.course_type = 'user' " +
        "AND c.regist_date >= NOW() - INTERVAL 14 DAY " +
        "ORDER BY c.count DESC " +
        "LIMIT 3",
        nativeQuery = true)
    List<Course> findPopularLately(@Param("area") String area);
}
