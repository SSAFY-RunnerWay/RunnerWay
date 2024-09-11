package chuchu.runnerway.course.mapper;

import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;
import chuchu.runnerway.course.entity.Course;
import org.mapstruct.*;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CourseMapper {
    CourseMapper INSTANCE = Mappers.getMapper(CourseMapper.class);

    @Mapping(source = "course.courseImage.url", target = "url")
    OfficialDetailResponseDto toOfficialDetailResponseDto(Course course);

    @Mapping(source = "course.courseImage.url", target = "url")
    @Named("OfficialList")
    OfficialListResponseDto toOfficialListResponseDto(Course course);

    @IterableMapping(qualifiedByName = "OfficialList")
    List<OfficialListResponseDto> toOfficialListResponseDtoList(List<Course> courses);
}
