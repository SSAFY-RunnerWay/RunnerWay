package chuchu.runnerway.member.dto;

import chuchu.runnerway.member.domain.JoinType;
import java.time.LocalDate;
import lombok.Data;

@Data
public class MemberDto {
    private Long memberId;
    private String email;
    private String nickname;
    private LocalDate birth;
    private JoinType joinType;
    private Integer gender;
    private Integer height;
    private Integer weight;
    private LocalDate createTime;
    private LocalDate resignTime;
    private Integer isResign;
}
