package chuchu.runnerway.runningRecord.model.repository;

import chuchu.runnerway.runningRecord.entity.RecommendationLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecommendationLogRepository extends JpaRepository<RecommendationLog, Long> {
}
