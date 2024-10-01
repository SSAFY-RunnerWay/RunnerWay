package chuchu.runnerway.runningRecord.dto.response;

import lombok.Data;

import java.sql.Time;
import java.time.LocalDateTime;

@Data
public class RecordMonthData {
    public RecordMonthData(double totalDistance, double averageFace, String totalScore, double totalCalorie) {
        this.totalDistance = totalDistance;
        this.averageFace = averageFace;
        this.totalScore = totalScore;
        this.totalCalorie = totalCalorie;
    }

    private double totalDistance;
    private double averageFace;
    private String totalScore;
    private double totalCalorie;
}
