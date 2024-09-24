package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.UserDetailResponseDto;

public interface IncrementCountService {
    OfficialDetailResponseDto incrementOfficalCourseCount(Long courseId);

    UserDetailResponseDto incrementUserCourseCount(Long courseId);
}
