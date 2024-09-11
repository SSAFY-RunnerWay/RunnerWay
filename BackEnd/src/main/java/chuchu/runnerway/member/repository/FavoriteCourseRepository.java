package chuchu.runnerway.member.repository;

import chuchu.runnerway.member.domain.FavoriteCourse;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FavoriteCourseRepository extends JpaRepository<FavoriteCourse, Long> {
}
