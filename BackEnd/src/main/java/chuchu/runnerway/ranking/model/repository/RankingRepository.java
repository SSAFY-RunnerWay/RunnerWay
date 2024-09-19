package chuchu.runnerway.ranking.model.repository;

import chuchu.runnerway.ranking.entity.Ranking;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RankingRepository extends JpaRepository<Ranking, Long> {

    Optional<Ranking> findByRankId(Long rankingId);

    List<Ranking> findByCourse_CourseIdOrderByScore(Long courseId);

    Ranking findByCourse_CourseIdAndMember_MemberId(Long courseId, Long memberId);
}
