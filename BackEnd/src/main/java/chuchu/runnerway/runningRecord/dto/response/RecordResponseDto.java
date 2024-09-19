package chuchu.runnerway.runningRecord.dto.response;

import lombok.Data;

import java.sql.Time;

@Data
public class RecordResponseDto {
    private Long recordId;
    private Long courseId;
    private String courseName;
    private double runningDistance;
    private Time score;
    private double averageFace;

}
