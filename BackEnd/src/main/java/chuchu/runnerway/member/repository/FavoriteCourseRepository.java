package chuchu.runnerway.member.repository;

import chuchu.runnerway.member.domain.FavoriteCourse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface FavoriteCourseRepository extends JpaRepository<FavoriteCourse, Long> {
    @Query(value = "SELECT COUNT(f) " +
        "FROM FavoriteCourse f " +
        "WHERE f.member.memberId = :memberId")
    Integer findReportCountById(@Param("memberId") Long memberId);
}
