package chuchu.runnerway.member.repository;

import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.domain.MemberImage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberImageRepository extends JpaRepository<MemberImage, Member> {
}
