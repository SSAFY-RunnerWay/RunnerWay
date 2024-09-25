package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.RecommendationDto;
import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.entity.CourseImage;
import chuchu.runnerway.course.mapper.CourseMapper;
import chuchu.runnerway.course.model.repository.CourseImageRepository;
import chuchu.runnerway.course.model.repository.CourseImageRepositoryPrimaryKey;
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
    private final CourseImageRepositoryPrimaryKey courseImageRepositoryPrimaryKey;
    private final CourseMapper courseMapper;

    @Override
    public List<RecommendationDto> findAllOfiicialCourse(double lat, double lng) {
        List<RecommendationDto> courses = getRecommendation(lat, lng);
        for(RecommendationDto course : courses) {
            Optional<CourseImage> courseImage = courseImageRepositoryPrimaryKey.findById(course.getCourseId());
            courseImage.ifPresent(image -> course.setCourseImage(courseMapper.toCourseImageDto(image)));
        }
        return courses;
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

    public List<RecommendationDto> getRecommendation (double lat, double lng) {
         Flux<RecommendationDto> dto = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/recommendation")
                        .queryParam("member_id", 13)
                        .queryParam("lat", lat)
                        .queryParam("lng", lng)
                        .build())
                .retrieve()
                .bodyToFlux(RecommendationDto.class);
        return dto.collectList().block();

    }
}
