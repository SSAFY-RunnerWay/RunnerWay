package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.UserDetailResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.entity.CourseImage;
import chuchu.runnerway.course.model.repository.OfficialCourseRepository;
import chuchu.runnerway.course.model.repository.UserCourseRepository;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.CachePut;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class IncrementCountServiceImpl implements IncrementCountService {

    private final OfficialCourseService officialCourseService;
    private final UserCourseService userCourseService;
    private final RedisTemplate<String, Object> redisTemplate;
    private final OfficialCourseRepository officialCourseRepository;
    private final UserCourseRepository userCourseRepository;
    private final MemberRepository memberRepository;

    @Override
    @CachePut(value = "officialCourseCache", key = "#courseId")
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
    @CachePut(value = "userCourseCache", key = "#courseId")
    public UserDetailResponseDto incrementUserCourseCount(Long courseId) {
        // 현재 캐시된 데이터를 가져오기 위해 getUserCourse 메서드를 호출
        UserDetailResponseDto courseDto = userCourseService.getUserCourse(courseId);

        if (courseDto != null) {
            // count 값 증가
            courseDto.setCount(courseDto.getCount() + 1);
        }

        return courseDto;
    }

    // 내일 아침에 잘 되는지 확인ㄱㄱ
    @Override
    @Scheduled(cron = "0 0 3 * * *")
    @Transactional
    public void updateAllCacheCountsToDB() {
        // 공식 코스
        Set<String> keys = redisTemplate.keys("officialCourseCache::*");
        List<Course> courseList = new ArrayList<>();

        for(String key : keys) {
            OfficialDetailResponseDto dto = officialCourseService.getOfficialCourse((Long.parseLong(key.substring(21))));

            CourseImage image = null;

            if(dto.getCourseImage() != null) {
                image = CourseImage.builder()
                        .courseId(dto.getCourseId())
                        .url(dto.getCourseImage().getUrl())
                        .path(dto.getCourseImage().getPath())
                        .build();
            }

            Optional<Member> member = memberRepository.findById(dto.getMemberId());

            Course course = Course.builder()
                    .courseId(dto.getCourseId())
                    .name(dto.getName())
                    .address(dto.getAddress())
                    .content(dto.getContent())
                    .count(dto.getCount())
                    .level(dto.getLevel())
                    .averageSlope(dto.getAverageSlope())
                    .averageTime(dto.getAverageTime())
                    .courseLength(dto.getCourseLength())
                    .averageCalorie(dto.getAverageCalorie())
                    .courseType(dto.getCourseType())
                    .lat(dto.getLat())
                    .lng(dto.getLng())
                    .courseImage(image)
                    .member(member.get())
                    .build();

            courseList.add(course);
        }

        officialCourseRepository.saveAll(courseList);
        redisTemplate.delete(keys);

        // 유저 코스
        keys.clear();
        keys = redisTemplate.keys("userCourseCache::*");
        courseList = new ArrayList<>();

        for(String key : keys) {
            UserDetailResponseDto dto = userCourseService.getUserCourse(Long.parseLong(key.substring(17)));

            CourseImage image = null;

            if(dto.getCourseImage() != null) {
                image = CourseImage.builder()
                        .courseId(dto.getCourseId())
                        .url(dto.getCourseImage().getUrl())
                        .path(dto.getCourseImage().getPath())
                        .build();
            }

            Optional<Member> member = memberRepository.findById(dto.getMemberId());

            Course course = Course.builder()
                    .courseId(dto.getCourseId())
                    .name(dto.getName())
                    .address(dto.getAddress())
                    .content(dto.getContent())
                    .count(dto.getCount())
                    .level(dto.getLevel())
                    .averageSlope(dto.getAverageSlope())
                    .averageTime(dto.getAverageTime())
                    .courseLength(dto.getCourseLength())
                    .averageCalorie(dto.getAverageCalorie())
                    .courseType(dto.getCourseType())
                    .lat(dto.getLat())
                    .lng(dto.getLng())
                    .courseImage(image)
                    .member(member.get())
                    .build();

            courseList.add(course);
        }

        userCourseRepository.saveAll(courseList);
        redisTemplate.delete(keys);
    }
}
