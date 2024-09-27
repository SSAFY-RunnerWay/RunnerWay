package chuchu.runnerway.course.mapper;

import chuchu.runnerway.course.dto.AreaDto;
import chuchu.runnerway.course.dto.CourseImageDto;
import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.entity.CourseImage;
import org.mapstruct.*;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CourseMapper {
    CourseMapper INSTANCE = Mappers.getMapper(CourseMapper.class);

    @Mapping(source = "course.courseImage.url", target = "courseImage.url")
    OfficialDetailResponseDto toOfficialDetailResponseDto(Course course);

    CourseImageDto toCourseImageDto(CourseImage courseImage);

    @Named("area")
    AreaDto toAreaDto(Course course);
    @IterableMapping(qualifiedByName = "area")
    List<AreaDto> toAreaDtoList(List<Course> courses);

    @Mapping(source = "course.courseImage.url", target = "courseImage.url")
    @Named("OfficialList")
    OfficialListResponseDto toOfficialListResponseDto(Course course);

    @IterableMapping(qualifiedByName = "OfficialList")
    List<OfficialListResponseDto> toOfficialListResponseDtoList(List<Course> courses);
}
