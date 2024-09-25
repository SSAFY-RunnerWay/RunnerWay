package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.request.UserCourseRegistRequestDto;
import chuchu.runnerway.course.dto.response.UserDetailResponseDto;
import chuchu.runnerway.course.dto.response.UserListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.entity.CourseImage;
import chuchu.runnerway.course.model.repository.CourseImageRepository;
import chuchu.runnerway.course.model.repository.UserCourseRepository;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.exception.NotFoundMemberException;
import chuchu.runnerway.member.repository.MemberRepository;
import java.util.Comparator;
import java.util.List;
import java.util.NoSuchElementException;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserCourseServiceImpl implements UserCourseService {

    private final UserCourseRepository userCourseRepository;
    private final CourseImageRepository courseImageRepository;
    private final ModelMapper mapper;
    private final MemberRepository memberRepository;

    @Transactional
    @Override
    public List<UserListResponseDto> findAllUserCourse(double lat, double lng) {
        List<Course> courses = userCourseRepository.findAll(lat, lng);

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
        Course course = userCourseRepository.findById(courseId)
            .orElseThrow(NoSuchElementException::new);
        UserDetailResponseDto dto = mapper.map(course, UserDetailResponseDto.class);
        dto.setNickname(course.getMember().getNickname());
        dto.setMemberId(course.getMember().getMemberId());
        return dto;
    }

    @Transactional
    @Override
    public void registUserCourse(UserCourseRegistRequestDto userCourseRegistRequestDto) {
        Course userCourse = Course.builder().build();
        Member member = memberRepository.findById(userCourseRegistRequestDto.getMemberId()).orElseThrow(
            NotFoundMemberException::new
        );

        userCourse.updateUserCourse(userCourseRegistRequestDto, member);
        Course savedCourse = userCourseRepository.save(userCourse);

        saveMemberImage(userCourseRegistRequestDto, savedCourse);
    }

    @Transactional
    @Override
    public List<UserListResponseDto> findPopularAllUserCourse(double lat, double lng) {
        List<Course> courses = userCourseRepository.findPopularAll(lat, lng);
        return courses.stream()
            .map(course -> {
                // Course -> UserListResponseDto 변환
                UserListResponseDto dto = mapper.map(course, UserListResponseDto.class);

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
        List<Course> courses = userCourseRepository.findPopularLately(lat, lng);
        return courses.stream()
            .map(course -> {
                // Course -> UserListResponseDto 변환
                UserListResponseDto dto = mapper.map(course, UserListResponseDto.class);

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
