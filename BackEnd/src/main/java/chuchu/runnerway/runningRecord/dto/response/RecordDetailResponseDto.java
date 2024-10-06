package chuchu.runnerway.runningRecord.dto.response;

import lombok.Data;

import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Data
public class RecordDetailResponseDto {
    private Long courseId;
    private String courseName;
    private String comment;
    private double runningDistance;
    private LocalDateTime startDate;
    private LocalDateTime finishDate;
    private String address;
    private LocalTime score;
    private double averageFace;
    private double calorie;
    private double lat;
    private double lng;
    private String url;
}
