package chuchu.runnerway.runningRecord.dto.response;

import lombok.Data;

import java.sql.Time;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Data
public class RecordResponseDto {
    private Long recordId;
    private Long courseId;
    private String courseName;
    private double runningDistance;
    private String address;
    private LocalDateTime startDate;
    private LocalTime score;
    private double averageFace;
    private double lat;
    private double lng;

}
