package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.request.OfficialCoordRequestDto;
import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;
import chuchu.runnerway.course.entity.Course;

import java.util.List;

public interface OfficialCourseService {

    List<OfficialListResponseDto> findAllOfiicialCourse(double lat, double lng);

    OfficialDetailResponseDto getOfficialCourse(Long courseId);

    OfficialDetailResponseDto incrementCourseCount(Long courseId);

    void updateAllCacheCountsToDB();
}
