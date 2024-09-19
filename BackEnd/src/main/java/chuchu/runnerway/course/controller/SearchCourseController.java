package chuchu.runnerway.course.controller;

import chuchu.runnerway.course.dto.response.SelectAllResponseDto;
import chuchu.runnerway.course.model.service.SearchCourseService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/search")
@RequiredArgsConstructor
public class SearchCourseController {
    private final SearchCourseService searchCourseService;

    @GetMapping
    @Operation(summary = "코스 검색", description = "코스 검색에 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "검색어와 일치한 코스 목록 조회",
                    content = @Content(mediaType = "application/json")
            ),
    })
    public ResponseEntity<?> search(@RequestParam("searchWord") String searchWord,
                                    @RequestParam(value = "page", defaultValue = "0") int page,
                                    @RequestParam(value = "size", defaultValue = "10") int size) {
        SelectAllResponseDto selectAllResponseDtoList = searchCourseService.search(searchWord, page, size);

        if(selectAllResponseDtoList.getSearchCourseList().isEmpty()) return ResponseEntity.status(200).body("검색 조건에 일치하는 결과가 없습니다.");

        return ResponseEntity.ok(selectAllResponseDtoList);
    }

    // 추후 스케줄링으로 변경할 api 입니다. 완성 후 지우겠슴다~
    @PostMapping
    public ResponseEntity<?> regist() {
        searchCourseService.insertCourse();

        return ResponseEntity.ok("성공");
    }
}
