package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.RecommendationDto;
import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.mapper.CourseMapper;
import chuchu.runnerway.course.model.repository.OfficialCourseRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class OfficialCourseServiceImpl implements OfficialCourseService{

    private final WebClient webClient;

    private final OfficialCourseRepository officialCourseRepository;
    private final CourseMapper courseMapper;
//    private final RedisTemplate<String, Object> redisTemplate;

    @Override
    public List<OfficialListResponseDto> findAllOfiicialCourse(double lat, double lng) {
        List<Course> courses = officialCourseRepository.findAll(lat, lng);
        getRecommendation();
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
































    public void getRecommendation () {
         Flux<RecommendationDto> dto = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/recommendation")
                        .queryParam("member_id", 13)
                        .build())
                .retrieve()
                .bodyToFlux(RecommendationDto.class);
        List<RecommendationDto> recommendations = dto.collectList().block();
        for(RecommendationDto recommendationDto : recommendations) {
            log.info("recommendationDto: {}, {}", recommendationDto.getCourseId(), recommendationDto.getRecommendationScore());
        }
//        dto.subscribe(
//                recommendationDto -> {
//                    // 추천 DTO의 필드를 출력
//                    log.info("Course ID: {}", recommendationDto.getCourseId());
//                    log.info("Recommendation Score: {}", + recommendationDto.getRecommendationScore());
//                },
//                error -> {
//                    // 에러 처리
//                    System.err.println("Error occurred: " + error.getMessage());
//                },
//                () -> {
//                    // 완료 시 호출되는 메소드
//                    log.info("Recommendation retrieval completed.");
//                }
//        );
    }
}
