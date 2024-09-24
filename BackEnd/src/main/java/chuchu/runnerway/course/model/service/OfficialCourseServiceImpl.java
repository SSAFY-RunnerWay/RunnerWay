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
    private final RedisTemplate<String, Object> redisTemplate;

    @Override
    public List<OfficialListResponseDto> findAllOfiicialCourse(double lat, double lng) {
        List<Course> courses = officialCourseRepository.findAll(lat, lng);
        return courseMapper.toOfficialListResponseDtoList(courses);
    }

    @Override
    @Cacheable(value = "courseCache", key = "#courseId", unless = "#result == null")
    public OfficialDetailResponseDto getOfficialCourse(Long courseId) {
        Course course = officialCourseRepository.findById(courseId)
                .orElseThrow(NoSuchElementException::new);

        return courseMapper.toOfficialDetailResponseDto(course);
    }

    // 내일 아침에 잘 되는지 확인ㄱㄱ
    @Override
    @Scheduled(cron = "0 0 3 * * *")
    @Transactional
    public void updateAllCacheCountsToDB() {
        Set<String> keys = redisTemplate.keys("courseCache::*");

        if(keys != null && !keys.isEmpty()) {
            // 키에 해당하는 데이터를 가져와, 리스트로 변환
            List<Course> courseList = keys.stream()
                    .map(key -> (Course) redisTemplate.opsForValue().get(key))
                    .filter(course -> course != null)
                    .collect(Collectors.toList());

            officialCourseRepository.saveAll(courseList);

            // 캐시 삭제
            redisTemplate.delete(keys);
        }

    }

}
