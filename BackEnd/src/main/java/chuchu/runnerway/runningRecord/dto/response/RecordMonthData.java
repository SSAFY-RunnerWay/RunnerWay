package chuchu.runnerway.runningRecord.dto.response;

import lombok.Data;

import java.sql.Time;

@Data
public class RecordMonthData {
    public RecordMonthData(double totalDistance, double averageFace, Time totalScore, double totalCalorie) {
        this.totalDistance = totalDistance;
        this.averageFace = averageFace;
        this.totalScore = totalScore;
        this.totalCalorie = totalCalorie;
    }

    private double totalDistance;
    private double averageFace;
    private Time totalScore;
    private double totalCalorie;
}
