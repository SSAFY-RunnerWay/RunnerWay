package chuchu.runnerway.ranking.dto.response;

import chuchu.runnerway.ranking.dto.reference.RankerMemberDto;
import lombok.Data;

import java.sql.Time;

@Data
public class RankingResponseDto {
    private Time score;
    private RankerMemberDto memberDto;
}
