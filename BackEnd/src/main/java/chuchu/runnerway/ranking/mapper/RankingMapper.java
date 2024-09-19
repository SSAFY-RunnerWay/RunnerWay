package chuchu.runnerway.ranking.mapper;

import chuchu.runnerway.course.mapper.CourseMapper;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.domain.MemberImage;
import chuchu.runnerway.member.dto.MemberImageDto;
import chuchu.runnerway.ranking.dto.reference.RankerMemberDto;
import chuchu.runnerway.ranking.dto.response.RankingResponseDto;
import chuchu.runnerway.ranking.entity.Ranking;
import org.mapstruct.*;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface RankingMapper {
    RankingMapper INSTANCE = Mappers.getMapper(RankingMapper.class);


    @Mapping(source = "member", target = "memberDto")
    @Named("ranking")
    RankingResponseDto toDto(Ranking ranking);

    // Member의 필드를 RankerMemberDto로 매핑
    @Mapping(source = "memberId", target = "memberId")
    @Mapping(source = "nickname", target = "nickname")
    @Mapping(source = "memberImage", target = "memberImage")
    RankerMemberDto toRankerMemberDto(Member member);

    // MemberImage를 MemberImageDto로 매핑
    @Mapping(source = "memberImage.memberId", target = "memberId")
    @Mapping(source = "memberImage.url", target = "url")
    @Mapping(source = "memberImage.path", target = "path")
    MemberImageDto toMemberImageDto(MemberImage memberImage);

    @IterableMapping(qualifiedByName = "ranking")
    List<RankingResponseDto> toRankingResponseDto(List<Ranking> rankings);
}
