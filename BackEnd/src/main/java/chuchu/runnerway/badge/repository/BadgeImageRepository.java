package chuchu.runnerway.badge.repository;

import chuchu.runnerway.badge.domain.BadgeImage;
import chuchu.runnerway.badge.domain.BadgeItems;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BadgeImageRepository extends JpaRepository<BadgeImage, BadgeItems> {

}
