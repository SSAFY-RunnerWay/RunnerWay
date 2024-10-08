package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.request.UserCourseRegistRequestDto;
import chuchu.runnerway.course.dto.response.RegistCourseResponseDto;
import chuchu.runnerway.course.dto.response.UserDetailResponseDto;
import chuchu.runnerway.course.dto.response.UserListResponseDto;
import java.util.List;

public interface UserCourseService {

    List<UserListResponseDto> findAllUserCourse(double lat, double lng);
    UserDetailResponseDto getUserCourse(Long courseId);
    RegistCourseResponseDto registUserCourse(UserCourseRegistRequestDto userCourseRegistRequestDto);
    List<UserListResponseDto> findPopularAllUserCourse(double lat, double lng);
    List<UserListResponseDto> findPopularLatelyUserCourse(double lat, double lng);
}
