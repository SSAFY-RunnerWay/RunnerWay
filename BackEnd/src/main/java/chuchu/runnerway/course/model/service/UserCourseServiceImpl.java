package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.response.UserListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.model.repository.UserCourseRepository;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserCourseServiceImpl implements UserCourseService {

    private final UserCourseRepository userCourseRepository;
    private final ModelMapper mapper;

    @Override
    public List<UserListResponseDto> findAllOfficialCourse(double lat, double lng) {
        List<Course> courses = userCourseRepository.findAll(lat, lng);

        return courses.stream()
            .map(course -> {
                // Course -> UserListResponseDto 변환
                UserListResponseDto dto = mapper.map(course, UserListResponseDto.class);

                // calcDistance 함수를 사용해 사용자와 코스 간의 거리 계산
                double distance = calcDistance(lat, lng, Double.parseDouble(course.getLat()), Double.parseDouble(course.getLng()));

                // 계산된 거리 값을 UserListResponseDto의 distance 변수에 설정
                dto.setDistance(distance);

                return dto;
            })
            // distance로 오름차순 정렬
            .sorted(Comparator.comparing(UserListResponseDto::getDistance))
            .toList();
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
