package chuchu.runnerway.runningRecord.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class RecordAnalyzeRequestDto {
    @NotNull
    @Min(2020)
    @Max(2100)
    private int year;

    @NotNull
    @Min(1)
    @Max(12)
    private int month;
}
