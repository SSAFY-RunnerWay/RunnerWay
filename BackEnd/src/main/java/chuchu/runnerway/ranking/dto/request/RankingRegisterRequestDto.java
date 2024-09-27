package chuchu.runnerway.ranking.dto.request;

import chuchu.runnerway.runningRecord.dto.PersonalImageDto;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDateTime;
import java.time.LocalTime;

@Data
public class RankingRegisterRequestDto {
    @NotNull
    private Long courseId;
    @NotNull
    private LocalTime score;
    @NotNull
    private String logPath;
}
