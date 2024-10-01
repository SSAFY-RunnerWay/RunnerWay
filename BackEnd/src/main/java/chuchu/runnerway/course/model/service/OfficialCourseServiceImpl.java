package chuchu.runnerway.course.model.service;

import chuchu.runnerway.common.util.MemberInfo;
import chuchu.runnerway.course.dto.AreaDto;
import chuchu.runnerway.course.dto.RecommendationDto;
import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.entity.CourseImage;
import chuchu.runnerway.course.mapper.CourseMapper;
import chuchu.runnerway.course.model.repository.CourseImageRepositoryPrimaryKey;
import chuchu.runnerway.course.model.repository.OfficialCourseRepository;
import com.uber.h3core.H3Core;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Flux;

import java.io.IOException;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class OfficialCourseServiceImpl implements OfficialCourseService{

    private final WebClient webClient;

    private final OfficialCourseRepository officialCourseRepository;
    private final CourseImageRepositoryPrimaryKey courseImageRepositoryPrimaryKey;
    private final CourseMapper courseMapper;
    private static final H3Core h3;
    private static final int resolution = 7;

    static {
        try {
            h3 = H3Core.newInstance();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<RecommendationDto> findAllOfiicialCourse(double lat, double lng) {
        List<RecommendationDto> courses = getRecommendation(lat, lng);
        if(courses.isEmpty()) return null;
        for(RecommendationDto course : courses) {
            Optional<CourseImage> courseImage = courseImageRepositoryPrimaryKey.findById(course.getCourseId());
            courseImage.ifPresent(image -> course.setCourseImage(courseMapper.toCourseImageDto(image)));
        }
        return courses;
    }

    @Override
    @Cacheable(value = "officialCourseCache", key = "#courseId", unless = "#result == null")
    public OfficialDetailResponseDto getOfficialCourse(Long courseId) {
        Course course = officialCourseRepository.findById(courseId).orElse(null);
        if(course == null) return null;
        OfficialDetailResponseDto dto = courseMapper.toOfficialDetailResponseDto(course);

        dto.setMemberId(course.getMember().getMemberId());

        return dto;
    }

    public List<RecommendationDto> getRecommendation (double lat, double lng) {
        Long memberId = MemberInfo.getId();
        String area = h3.geoToH3Address(lat, lng, resolution);
        log.info("area: {}", area);
        Flux<RecommendationDto> dto = webClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/recommendation")
                        .queryParam("member_id", memberId)
                        .queryParam("area", area)
                        .build())
                .retrieve()
                .bodyToFlux(RecommendationDto.class);
        return dto.collectList().block();

    }

    public List<AreaDto> area() throws IOException {
        List<Course> data = officialCourseRepository.findByCourseIdNot(0L);

        for(Course course : data) {
            String h3Index = h3.geoToH3Address(course.getLat(), course.getLng(), resolution);
            officialCourseRepository.updateArea(course.getCourseId(), h3Index);
        }

        return courseMapper.toAreaDtoList(data);
    }
}
