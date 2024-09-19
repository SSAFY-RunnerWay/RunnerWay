package chuchu.runnerway.course.model.service;

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

@Service
@RequiredArgsConstructor
public class SearchCourseServiceImpl implements SearchCourseService{
    private final ElasticSearchCourseRepository elasticSearchCourseRepository;
    private final OfficialCourseRepository officialCourseRepository;

    // 검색
    @Override
    public SelectAllResponseDto search(String searchWord, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "courseId"));

//        List<ElasticSearchCourse> sd = elasticSearchCourseRepository.findByName(searchWord);
//        List<SearchCourseResponseDto> searchCourseResponseDtoList = sd.stream().map(domain -> new SearchCourseResponseDto(
//                domain.getCourseId(),
//                domain.getName(),
//                domain.getAddress(),
//                domain.getContent(),
//                domain.getCount(),
//                domain.getLevel(),
//                domain.getAverageSlope(),
//                domain.getAverageDownhill(),
//                domain.getAverageTime(),
//                domain.getCourseLength(),
//                domain.getMemberId(),
//                domain.getCourseType(),
//                domain.getRegistDate(),
//                domain.getAverageCalorie(),
//                domain.getLat(),
//                domain.getLng()
//        )).toList();

        Page<ElasticSearchCourse> searchPage = elasticSearchCourseRepository.findByName(searchWord, pageable);

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
                        domain.getCourseType(),
                        domain.getRegistDate(),
                        domain.getAverageCalorie(),
                        domain.getLat(),
                        domain.getLng()
                )).toList();

        elasticSearchCourseRepository.saveAll(elasticSearchCourseList);
    }
}
