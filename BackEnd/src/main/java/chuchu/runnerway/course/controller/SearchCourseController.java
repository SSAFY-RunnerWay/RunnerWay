package chuchu.runnerway.course.controller;

import chuchu.runnerway.course.dto.response.SelectAllResponseDto;
import chuchu.runnerway.course.model.service.SearchCourseService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/search")
@RequiredArgsConstructor
public class SearchCourseController {
    private final SearchCourseService searchCourseService;

    @GetMapping
    public ResponseEntity<?> search(@RequestParam("searchWord") String searchWord,
                                    @RequestParam(value = "page", defaultValue = "0") int page,
                                    @RequestParam(value = "size", defaultValue = "10") int size) {
        SelectAllResponseDto selectAllResponseDtoList = searchCourseService.search(searchWord, page, size);

        if(selectAllResponseDtoList == null) return ResponseEntity.status(404).body("page를 찾을 수 없습니다.");

        if(selectAllResponseDtoList.getSearchCourseList().isEmpty()) return ResponseEntity.status(200).body("검색 조건에 일치하는 결과가 없습니다.");

        return ResponseEntity.ok(selectAllResponseDtoList);
    }

    @PostMapping
    public ResponseEntity<?> regist() {
        searchCourseService.insertCourse();

        return ResponseEntity.ok("성공");
    }
}
