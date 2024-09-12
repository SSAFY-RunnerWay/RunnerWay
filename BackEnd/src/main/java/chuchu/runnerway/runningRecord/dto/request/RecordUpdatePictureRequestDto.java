package chuchu.runnerway.runningRecord.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class RecordUpdatePictureRequestDto {
    @NotNull
    private Long recordId;
    @NotNull
    private String url;
    @NotNull
    private String path;
}
