package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.response.UserListResponseDto;
import java.util.List;

public interface UserCourseService {

    List<UserListResponseDto> findAllOfficialCourse(double lat, double lng);
}
