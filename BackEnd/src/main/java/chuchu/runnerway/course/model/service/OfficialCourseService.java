package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.AreaDto;
import chuchu.runnerway.course.dto.RecommendationDto;
import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;

import java.io.IOException;
import java.util.List;

public interface OfficialCourseService {

    List<RecommendationDto> findAllOfiicialCourse(double lat, double lng);

    OfficialDetailResponseDto getOfficialCourse(Long courseId);

    List<AreaDto> area() throws IOException;
//    void updateAllCacheCountsToDB();
}
