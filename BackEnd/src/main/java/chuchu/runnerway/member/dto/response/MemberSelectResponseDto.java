package chuchu.runnerway.member.dto.response;

import chuchu.runnerway.member.domain.JoinType;
import chuchu.runnerway.member.dto.MemberImageDto;
import java.time.LocalDate;
import lombok.Data;

@Data
public class MemberSelectResponseDto {
    private LocalDate birth;
    private JoinType joinType;
    private Integer gender;
    private Integer height;
    private Integer weight;
    private MemberImageDto memberImage;
}
