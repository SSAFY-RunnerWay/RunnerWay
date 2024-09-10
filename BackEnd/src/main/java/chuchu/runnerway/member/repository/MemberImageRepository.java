package chuchu.runnerway.member.repository;

import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.domain.MemberImage;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberImageRepository extends JpaRepository<MemberImage, Member> {
    Optional<MemberImage> findByMember(Member member);
}
