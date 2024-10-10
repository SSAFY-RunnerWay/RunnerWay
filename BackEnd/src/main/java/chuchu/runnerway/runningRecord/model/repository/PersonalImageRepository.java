package chuchu.runnerway.runningRecord.model.repository;

import chuchu.runnerway.runningRecord.entity.PersonalImage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PersonalImageRepository extends JpaRepository<PersonalImage, Long> {
    Optional<PersonalImage> findByRecordId(Long recordId);
}
