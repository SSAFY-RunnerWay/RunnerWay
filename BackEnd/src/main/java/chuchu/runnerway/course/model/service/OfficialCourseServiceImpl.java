package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.mapper.CourseMapper;
import chuchu.runnerway.course.model.repository.OfficialCourseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OfficialCourseServiceImpl implements OfficialCourseService{

    private final OfficialCourseRepository officialCourseRepository;
    private final CourseMapper courseMapper;
//    private final RedisTemplate<String, Object> redisTemplate;

    @Override
    public List<OfficialListResponseDto> findAllOfiicialCourse(double lat, double lng) {
        List<Course> courses = officialCourseRepository.findAll(lat, lng);
        return courseMapper.toOfficialListResponseDtoList(courses);
    }

    @Override
    @Cacheable(value = "officialCourseCache", key = "#courseId", unless = "#result == null")
    public OfficialDetailResponseDto getOfficialCourse(Long courseId) {
        Course course = officialCourseRepository.findById(courseId)
                .orElseThrow(NoSuchElementException::new);

        OfficialDetailResponseDto dto = courseMapper.toOfficialDetailResponseDto(course);
        dto.setMemberId(course.getMember().getMemberId());

        return dto;
    }

}
