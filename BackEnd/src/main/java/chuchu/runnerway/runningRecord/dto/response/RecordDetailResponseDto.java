package chuchu.runnerway.runningRecord.dto.response;

import lombok.Data;

import java.sql.Time;
import java.sql.Timestamp;

@Data
public class RecordDetailResponseDto {
    private Long courseId;
    private String courseName;
    private String comment;
    private Timestamp startDate;
    private Time score;
    private double averageFace;
    private double calorie;

    private String url;
}
