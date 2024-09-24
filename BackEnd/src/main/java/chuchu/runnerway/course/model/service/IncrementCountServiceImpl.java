package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.UserDetailResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.CachePut;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IncrementCountServiceImpl implements IncrementCountService {

    private final OfficialCourseService officialCourseService;
    private final UserCourseService userCourseService;

    @Override
    @CachePut(value = "courseCache", key = "#courseId")
    public OfficialDetailResponseDto incrementOfficalCourseCount(Long courseId) {
        // 현재 캐시된 데이터를 가져오기 위해 getOfficialCourse 메서드를 호출
        OfficialDetailResponseDto courseDto = officialCourseService.getOfficialCourse(courseId);

        if (courseDto != null) {
            // count 값 증가
            courseDto.setCount(courseDto.getCount() + 1);
        }

        return courseDto;
    }

    @Override
    @CachePut(value = "courseCache", key = "#courseId")
    public UserDetailResponseDto incrementUserCourseCount(Long courseId) {
        // 현재 캐시된 데이터를 가져오기 위해 getUserCourse 메서드를 호출
        UserDetailResponseDto courseDto = userCourseService.getUserCourse(courseId);

        if (courseDto != null) {
            // count 값 증가
            courseDto.setCount(courseDto.getCount() + 1);
        }

        return courseDto;
    }
}
