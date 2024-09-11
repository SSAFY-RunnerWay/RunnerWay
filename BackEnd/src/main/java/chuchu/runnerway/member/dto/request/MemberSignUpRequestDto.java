package chuchu.runnerway.member.dto.request;

import chuchu.runnerway.member.domain.JoinType;
import chuchu.runnerway.member.dto.MemberImageDto;
import java.time.LocalDate;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MemberSignUpRequestDto {
    private String email;
    private String nickname;
    private LocalDate birth;
    private JoinType joinType;
    private Integer height;
    private Integer weight;
    private MemberImageDto memberImage;
}
