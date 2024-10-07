package chuchu.runnerway.course.controller;

import chuchu.runnerway.course.dto.response.MatchByWordResponseDto;
import chuchu.runnerway.course.dto.response.SelectAllResponseDto;
import chuchu.runnerway.course.model.service.SearchCourseService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


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

        if(selectAllResponseDtoList.getSearchCourseList().isEmpty()) return ResponseEntity.status(204).body("검색 조건에 일치하는 결과가 없습니다.");

        return ResponseEntity.ok(selectAllResponseDtoList);
    }

    @GetMapping("/candidate")
    @Operation(summary = "검색어 매칭", description = "검색 자동완성에 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "사용자가 입력한 단어와 일치하는 검색어 후보 조회",
                    content = @Content(mediaType = "application/json")
            ),
    })
    public ResponseEntity<?> matchByWord(@RequestParam("searchWord") String searchWord) {
        List<MatchByWordResponseDto> matchByWordResponseDtoList = searchCourseService.matchByWord(searchWord);

        return ResponseEntity.ok(matchByWordResponseDtoList);
    }
}
