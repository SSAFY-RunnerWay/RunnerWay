package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;

import java.util.List;

public interface OfficialCourseService {

    List<OfficialListResponseDto> findAllOfiicialCourse(double lat, double lng);

    OfficialDetailResponseDto getOfficialCourse(Long courseId);

    void updateAllCacheCountsToDB();
}
