package chuchu.runnerway.badge.repository;

import chuchu.runnerway.badge.domain.Badge;
import chuchu.runnerway.member.domain.Member;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BadgeRepository extends JpaRepository<Badge, Long> {
    List<Badge> findAllByMember(Member member);
}
