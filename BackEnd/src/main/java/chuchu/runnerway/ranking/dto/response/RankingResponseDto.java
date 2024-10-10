package chuchu.runnerway.ranking.dto.response;

import chuchu.runnerway.ranking.dto.reference.RankerMemberDto;
import lombok.Data;

import java.time.LocalTime;

@Data
public class RankingResponseDto {
    private Long rankId;
    private LocalTime score;
    private RankerMemberDto memberDto;
}
