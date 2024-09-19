package chuchu.runnerway.runningRecord.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class RecordUpdateCommentRequestDto {

    @NotNull
    private Long recordId;
    @NotNull
    private String comment;
}
