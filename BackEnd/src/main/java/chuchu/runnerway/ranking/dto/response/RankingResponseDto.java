package chuchu.runnerway.ranking.dto.response;

import chuchu.runnerway.ranking.dto.reference.RankerMemberDto;
import lombok.Data;

import java.sql.Time;
import java.time.LocalTime;

@Data
public class RankingResponseDto {
    private LocalTime score;
    private RankerMemberDto memberDto;
}
