package chuchu.runnerway.runningRecord.dto.request;

import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.runningRecord.dto.PersonalImageDto;
import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.sql.Time;
import java.sql.Timestamp;

@Data
public class RecordRegistRequestDto {

    @NotNull
    private Long courseId;

    @NotNull
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm:ss")
    private Time score;
    @NotNull
    private double runningDistance;
    @NotNull
    private double calorie;
    @NotNull
    private double averageFace;
    private String comment;
    @NotNull
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private Timestamp startDate;
    @NotNull
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    private Timestamp finishDate;
    private PersonalImageDto personalImage;
    private String logPath;

}
