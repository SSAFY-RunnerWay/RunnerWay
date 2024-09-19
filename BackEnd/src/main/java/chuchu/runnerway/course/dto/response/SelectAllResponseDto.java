package chuchu.runnerway.course.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;

import java.util.List;

@Builder
@AllArgsConstructor
@Getter
@EqualsAndHashCode
public class SelectAllResponseDto {
    private List<SearchCourseResponseDto> searchCourseList;

    // 추가 페이징 정보
    private int page;
    private int size;
    private long totalElements;
    private int totalPages;
}
