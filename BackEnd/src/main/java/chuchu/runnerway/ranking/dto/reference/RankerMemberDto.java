package chuchu.runnerway.ranking.dto.reference;

import chuchu.runnerway.member.dto.MemberImageDto;
import lombok.Data;

@Data
public class RankerMemberDto {

    private Long memberId;
    private String nickname;
    private MemberImageDto memberImage;
}
