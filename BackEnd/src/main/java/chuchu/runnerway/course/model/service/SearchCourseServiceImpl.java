package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.response.MatchByWordResponseDto;
import chuchu.runnerway.course.dto.response.SearchCourseResponseDto;
import chuchu.runnerway.course.dto.response.SelectAllResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.entity.ElasticSearchCourse;
import chuchu.runnerway.course.model.repository.ElasticSearchCourseRepository;
import chuchu.runnerway.course.model.repository.OfficialCourseRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Stream;

@Service
@RequiredArgsConstructor
public class SearchCourseServiceImpl implements SearchCourseService{
    private final ElasticSearchCourseRepository elasticSearchCourseRepository;
    private final OfficialCourseRepository officialCourseRepository;

    // 검색
    @Override
    public SelectAllResponseDto search(String searchWord, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "courseId"));

        Page<ElasticSearchCourse> searchPage = elasticSearchCourseRepository.findByNameOrAddressOrMemberNickname(searchWord, searchWord, searchWord, pageable);

        List<SearchCourseResponseDto> searchCourseResponseDtoList = searchPage.getContent().stream()
                .map(domain -> new SearchCourseResponseDto(
                        domain.getCourseId(),
                        domain.getName(),
                        domain.getAddress(),
                        domain.getContent(),
                        domain.getCount(),
                        domain.getLevel(),
                        domain.getAverageSlope(),
                        domain.getAverageDownhill(),
                        domain.getAverageTime(),
                        domain.getCourseLength(),
                        domain.getMemberId(),
                        domain.getMemberNickname(),
                        domain.getCourseType(),
                        domain.getRegistDate(),
                        domain.getAverageCalorie(),
                        domain.getLat(),
                        domain.getLng()
                ))
                .toList();

        return SelectAllResponseDto.builder()
                .searchCourseList(searchCourseResponseDtoList)
                .page(page)
                .size(size)
                .totalElements(searchPage.getTotalElements())
                .totalPages(searchPage.getTotalPages())
                .build();
    }

    // 후보 검색
    @Override
    public List<MatchByWordResponseDto> matchByWord(String searchWord) {
        Pageable pageable = PageRequest.of(0, 10); // 최대 10개 결과만 받아옴

        Page<ElasticSearchCourse> elasticSearchCourseList = elasticSearchCourseRepository.findByNameOrAddressOrMemberNickname(searchWord, searchWord, searchWord, pageable);

        return elasticSearchCourseList.stream()
                .flatMap(course -> Stream.of(course.getName(), course.getAddress(), course.getMemberNickname()))
                .filter(Objects::nonNull) // null 아닌 것 중에
                .filter(value -> value.startsWith(searchWord)) // 입력어로 시작하는 검색어들만
                .distinct() // 중복제거
                .limit(10) // 10개만
                .map(word -> new MatchByWordResponseDto(word)) // Dto로 파싱
                .toList();
    }

    @Override
    @Transactional
    @Scheduled(cron = "0 0 3 * * *", zone = "Asia/Seoul") // 매일 새벽 3시에 elastic index 갱신
    public void insertCourse() {
        elasticSearchCourseRepository.deleteAll();

        List<Course> coruseList = officialCourseRepository.findAll();

        List<ElasticSearchCourse> elasticSearchCourseList = coruseList.stream()
                .map(domain -> new ElasticSearchCourse(
                        domain.getCourseId(),
                        domain.getName(),
                        domain.getAddress(),
                        domain.getContent(),
                        domain.getCount(),
                        domain.getLevel(),
                        domain.getAverageSlope(),
                        domain.getAverageDownhill(),
                        domain.getAverageTime(),
                        domain.getCourseLength(),
                        domain.getMember().getMemberId(),
                        domain.getMember().getNickname(),
                        domain.getCourseType(),
                        domain.getRegistDate(),
                        domain.getAverageCalorie(),
                        domain.getLat(),
                        domain.getLng()
                )).toList();

        elasticSearchCourseRepository.saveAll(elasticSearchCourseList);
    }
}
