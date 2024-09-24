package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.request.OfficialCoordRequestDto;
import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.mapper.CourseMapper;
import chuchu.runnerway.course.model.repository.OfficialCourseRepository;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.CachePut;
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

    // 참여자 수 갱신(미완성)
    @Override
    @CachePut(value = "courseCache", key="#courseId")
    public OfficialDetailResponseDto incrementCourseCount(Long courseId) {
        // 지금 한 번 갱신밖에 안됨. 아마도, 원본 DB 기반 update를 진행중인듯? 캐싱 데이터에 먼저 접근해보자
        OfficialDetailResponseDto courseDto = null;

//        Object cachedValue = redisTemplate.opsForValue().get("courseCache::" + courseId.toString());
//
//        if(cachedValue != null) {
//            try {
//                System.out.println(cachedValue);
//
//                ObjectMapper objectMapper = new ObjectMapper();
//                JsonNode rootNode = objectMapper.readTree(cachedValue.toString());
//
//                // 1단계: 첫 번째 리스트의 클래스 정보를 제거하고 두 번째 요소만 추출
//                JsonNode actualDataNode = rootNode.get(1); // 첫 번째 요소는 클래스명, 두 번째 요소는 실제 데이터
//
//                // 파싱된 결과를 확인하기 위해 출력
//                System.out.println("1단계 파싱 결과: " + actualDataNode.toString());
//            }
//        }

//        System.out.println("이건: "+courseDto.getCount());

//        courseDto.setCount(courseDto.getCount() + 1);

        return courseDto;
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
