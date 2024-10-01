package chuchu.runnerway.runningRecord.model.repository;

import chuchu.runnerway.runningRecord.dto.response.RecordMonthData;
import chuchu.runnerway.runningRecord.entity.RunningRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface RunningRecordRepository extends JpaRepository<RunningRecord, Long> {

    @Query(value = "select rc from RunningRecord rc " +
            "join fetch rc.course " +
            "where YEAR(rc.startDate) = :year and " +
            "MONTH(rc.startDate) = :month and " +
            "(DAY(rc.startDate) = :day or :day is null)")
    List<RunningRecord> findByDate(
            @Param("year") int year,
            @Param("month") int month,
            @Param("day") Integer day);

    Optional<RunningRecord> findByRecordId(Long recordId);

//    @Query(value = "SELECT new com.chuchu.runnerway.runningRecord.dto.response.RecordMonthData(SUM(rr.runningDistance), AVG(rr.averageFace), SEC_TO_TIME(SUM(TIME_TO_SEC(rr.score))), SUM(rr.calorie)) " +
//            "FROM RunningRecord rr " +
//            "WHERE YEAR(rr.startDate) = :year " +
//            "AND MONTH(rr.startDate) = :month")
//    Optional<RecordMonthData> getRecordMonthData(@Param("year") int year, @Param("month") int month);
    @Query(value = "SELECT SUM(rr.running_distance) AS totalDistance, " +
        "AVG(rr.average_face) AS averageFace, " +
        "SUM(TIME_TO_SEC(rr.score)) AS totalScore, " +
        "SUM(rr.calorie) AS totalCalorie " +
        "FROM running_record rr " +
        "WHERE YEAR(rr.start_date) = :year " +
        "AND MONTH(rr.start_date) = :month",
        nativeQuery = true)
    Optional<Map<String, Object>> getRecordMonthData(@Param("year") int year, @Param("month") int month);
}
