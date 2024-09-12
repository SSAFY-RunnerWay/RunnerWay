package chuchu.runnerway.runningRecord.mapper;

import chuchu.runnerway.runningRecord.dto.request.RecordRegistRequestDto;
import chuchu.runnerway.runningRecord.dto.response.RecordDetailResponseDto;
import chuchu.runnerway.runningRecord.dto.response.RecordResponseDto;
import chuchu.runnerway.runningRecord.entity.RunningRecord;
import org.mapstruct.*;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface RunningRecordMapper {
    RunningRecordMapper INSTANCE = Mappers.getMapper(RunningRecordMapper.class);

    @Mapping(source = "course.name", target = "courseName")
    @Mapping(source = "course.courseId", target = "courseId")
    @Mapping(source = "personalImage.url", target = "url")
    RecordDetailResponseDto toRecordDetailResponseDto(RunningRecord runningRecord);

    @Mapping(source = "course.name", target = "courseName")
    @Mapping(source = "course.courseId", target = "courseId")
    @Named("RecordList")
    RecordResponseDto toRecordResponseDto(RunningRecord runningRecord);

    @IterableMapping(qualifiedByName = "RecordList")
    List<RecordResponseDto> toRecordResponseDtoList(List<RunningRecord> runningRecordList);

    @Mapping(source = "courseId", target = "course.courseId")
    RunningRecord toRegistRunningRecordDto(RecordRegistRequestDto requestDto);
}
