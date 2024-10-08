package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.SlopeDto;
import chuchu.runnerway.course.dto.request.UserCourseRegistRequestDto;
import chuchu.runnerway.course.dto.response.RegistCourseResponseDto;
import chuchu.runnerway.course.dto.response.UserDetailResponseDto;
import chuchu.runnerway.course.dto.response.UserListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.entity.CourseImage;
import chuchu.runnerway.course.entity.ElasticSearchCourse;
import chuchu.runnerway.course.model.repository.CourseImageRepository;
import chuchu.runnerway.course.model.repository.ElasticSearchCourseRepository;
import chuchu.runnerway.course.model.repository.UserCourseRepository;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.exception.NotFoundMemberException;
import chuchu.runnerway.member.repository.MemberRepository;

import java.io.IOException;
import java.util.Comparator;
import java.util.List;
import java.util.NoSuchElementException;

import chuchu.runnerway.runningRecord.entity.RunningRecord;
import chuchu.runnerway.runningRecord.model.repository.RunningRecordRepository;
import com.uber.h3core.H3Core;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Service
@RequiredArgsConstructor
public class UserCourseServiceImpl implements UserCourseService {

    private final UserCourseRepository userCourseRepository;
    private final CourseImageRepository courseImageRepository;
    private final ModelMapper mapper;
    private final MemberRepository memberRepository;
    private final RunningRecordRepository runningRecordRepository;
    private static final H3Core h3;
    private static final int resolution = 7;

    static {
        try {
            h3 = H3Core.newInstance();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private final WebClient webClient;
    private final ElasticSearchCourseRepository elasticSearchCourseRepository;

    @Transactional
    @Override
    public List<UserListResponseDto> findAllUserCourse(double lat, double lng) {
        String h3Index = h3.geoToH3Address(lat, lng, resolution);
        List<Course> courses = userCourseRepository.findAll(h3Index);

        return courses.stream()
            .map(course -> {
                // Course -> UserListResponseDto 변환
                UserListResponseDto dto = mapper.map(course, UserListResponseDto.class);
                dto.setNickname(course.getMember().getNickname());
                // calcDistance 함수를 사용해 사용자와 코스 간의 거리 계산
                double distance = calcDistance(lat, lng, course.getLat(), course.getLng());

                // 계산된 거리 값을 UserListResponseDto의 distance 변수에 설정
                dto.setDistance(distance);

                return dto;
            })
            // distance로 오름차순 정렬
            .sorted(Comparator.comparing(UserListResponseDto::getDistance))
            .toList();
    }

    @Transactional
    @Override
    @Cacheable(value = "userCourseCache", key = "#courseId", unless = "#result == null")
    public UserDetailResponseDto getUserCourse(Long courseId) {
        Course course = userCourseRepository.findById(courseId).orElse(null);
        if(course == null) return null;

        UserDetailResponseDto dto = mapper.map(course, UserDetailResponseDto.class);
        dto.setNickname(course.getMember().getNickname());
        dto.setMemberId(course.getMember().getMemberId());
        return dto;
    }

    @Transactional
    @Override
    public RegistCourseResponseDto registUserCourse(UserCourseRegistRequestDto userCourseRegistRequestDto) {
        Course userCourse = Course.builder().build();
        RunningRecord record = runningRecordRepository.findByRecordId(userCourseRegistRequestDto.getRecordId())
                .orElseThrow(NoSuchElementException::new);
        if(record.getCourse().getCourseId() != 0) return new RegistCourseResponseDto(null, false);

        Member member = memberRepository.findById(userCourseRegistRequestDto.getMemberId()).orElseThrow(
            NotFoundMemberException::new
        );
        // 경사도 계산 및 레벨 계산
        Mono<SlopeDto> dto = webClient.get()
                        .uri(uriBuilder -> uriBuilder
                                .path("/slope")
                                .queryParam("S3_URL", userCourseRegistRequestDto.getUrl())
                                .build())
                        .retrieve()
                        .bodyToMono(SlopeDto.class);

        SlopeDto slopeDto = dto.block();
        if(slopeDto != null) {
            userCourseRegistRequestDto.setAverageSlope(slopeDto.getAverageSlope());
            userCourseRegistRequestDto.setAverageDownhill(slopeDto.getAverageDownhill());
            if(slopeDto.getAverageSlope() < 10) {
                if(userCourseRegistRequestDto.getCourseLength() < 5)
                    userCourseRegistRequestDto.setLevel(1);
                else
                    userCourseRegistRequestDto.setLevel(2);
            }
            else if(slopeDto.getAverageSlope() < 20) {
                if(userCourseRegistRequestDto.getCourseLength() < 3)
                    userCourseRegistRequestDto.setLevel(2);
                else
                    userCourseRegistRequestDto.setLevel(3);
            }
            else
                userCourseRegistRequestDto.setLevel(3);
        }

        String area = h3.geoToH3Address(userCourseRegistRequestDto.getLat(), userCourseRegistRequestDto.getLng(), resolution);
        userCourseRegistRequestDto.setArea(area);

        userCourse.updateUserCourse(userCourseRegistRequestDto, member);
        Course savedCourse = userCourseRepository.save(userCourse);
        saveMemberImage(userCourseRegistRequestDto, savedCourse);

        // 나혼자뛰기 기록 courseId 변경

        record.updateRecordCourse(savedCourse);
        runningRecordRepository.save(record);

        // ELK 갱신
        ElasticSearchCourse elasticSearchCourse = ElasticSearchCourse.builder()
                .courseId(savedCourse.getCourseId())
                .name(savedCourse.getName())
                .address(savedCourse.getAddress())
                .content(savedCourse.getContent())
                .count(savedCourse.getCount())
                .level(savedCourse.getLevel())
                .averageSlope(savedCourse.getAverageSlope())
                .averageDownhill(savedCourse.getAverageDownhill())
                .averageTime(savedCourse.getAverageTime())
                .courseLength(savedCourse.getCourseLength())
                .memberId(savedCourse.getMember().getMemberId())
                .memberNickname(savedCourse.getMember().getNickname())
                .courseType(savedCourse.getCourseType())
                .registDate(savedCourse.getRegistDate())
                .averageCalorie(savedCourse.getAverageCalorie())
                .lat(savedCourse.getLat())
                .lng(savedCourse.getLng())
                .url(savedCourse.getCourseImage().getUrl())
                .build();

        elasticSearchCourseRepository.save(elasticSearchCourse);

        return new RegistCourseResponseDto(savedCourse.getCourseId(), true);
    }

    @Transactional
    @Override
    public List<UserListResponseDto> findPopularAllUserCourse(double lat, double lng) {
        String h3Index = h3.geoToH3Address(lat, lng, resolution);
        List<Course> courses = userCourseRepository.findPopularAll(h3Index);
        return courses.stream()
            .map(course -> {
                // Course -> UserListResponseDto 변환
                UserListResponseDto dto = mapper.map(course, UserListResponseDto.class);
                dto.setNickname(course.getMember().getNickname());
                // calcDistance 함수를 사용해 사용자와 코스 간의 거리 계산
                double distance = calcDistance(lat, lng, course.getLat(), course.getLng());

                // 계산된 거리 값을 UserListResponseDto의 distance 변수에 설정
                dto.setDistance(distance);

                return dto;
            })
            .toList();
    }

    @Transactional
    @Override
    public List<UserListResponseDto> findPopularLatelyUserCourse(double lat, double lng) {
        String h3Index = h3.geoToH3Address(lat, lng, resolution);
        List<Course> courses = userCourseRepository.findPopularLately(h3Index);
        return courses.stream()
            .map(course -> {
                // Course -> UserListResponseDto 변환
                UserListResponseDto dto = mapper.map(course, UserListResponseDto.class);
                dto.setNickname(course.getMember().getNickname());
                // calcDistance 함수를 사용해 사용자와 코스 간의 거리 계산
                double distance = calcDistance(lat, lng, course.getLat(), course.getLng());

                // 계산된 거리 값을 UserListResponseDto의 distance 변수에 설정
                dto.setDistance(distance);

                return dto;
            })
            .toList();
    }

    private void saveMemberImage(
        UserCourseRegistRequestDto userCourseRegistRequestDto,
        Course savedCourse
    ) {
        CourseImage courseImage = CourseImage.builder()
            .course(savedCourse)
            .url(userCourseRegistRequestDto.getCourseImage().getUrl())
            .path(userCourseRegistRequestDto.getCourseImage().getPath())
            .build();
        courseImageRepository.save(courseImage);
    }

    private double calcDistance(double slat, double slng, double elat, double elng) {
        final int EARTH_RADIUS = 6371; // 지구 반지름 (단위: km)

        // 위도와 경도를 라디안으로 변환
        double dLat = Math.toRadians(elat - slat);
        double dLng = Math.toRadians(elng - slng);

        // 시작점과 끝점의 위도를 라디안으로 변환
        double startLatRad = Math.toRadians(slat);
        double endLatRad = Math.toRadians(elat);

        // 하버사인 공식 적용
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(startLatRad) * Math.cos(endLatRad) *
                Math.sin(dLng / 2) * Math.sin(dLng / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        // 거리 계산 (단위: km)
        double distance = EARTH_RADIUS * c;

        return Double.parseDouble(String.format("%.3f", distance));
    }
}
