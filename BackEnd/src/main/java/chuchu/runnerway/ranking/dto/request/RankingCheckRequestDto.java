package chuchu.runnerway.ranking.dto.request;

import lombok.Data;

import java.time.LocalTime;

@Data
public class RankingCheckRequestDto {
    public RankingCheckRequestDto() {
    }

    public RankingCheckRequestDto(Long courseId, String score) {
        this.courseId = courseId;
        this.score = score;
    }

    private Long courseId;
    private String score;
}
