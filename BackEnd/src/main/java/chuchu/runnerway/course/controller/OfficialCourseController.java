package chuchu.runnerway.course.controller;

import chuchu.runnerway.course.dto.request.OfficialCoordRequestDto;
import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.model.service.OfficialCourseService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/officialCourse")
@RequiredArgsConstructor
@Slf4j
public class OfficialCourseController {

    private final OfficialCourseService officialCourseService;

    
    @GetMapping("/list")
    @Operation(summary = "공식 코스 목록 조회", description = "공식 코스 목록 조회할 때 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "공식코스 목록 조회",
                    content = @Content(mediaType = "application/json")
            ),
    })
    public ResponseEntity<?> findAllOfficialCourses(@RequestParam double lat, @RequestParam double lng) {
        List<OfficialListResponseDto> courses = officialCourseService.findAllOfiicialCourse(lat, lng);
        return ResponseEntity.ok(courses);
    }

    @GetMapping("/detail/{courseId}")
    @Operation(summary = "공식 코스 상세 조회", description = "공식 코스 상세 조회할 때 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "공식코스 상세 조회",
                    content = @Content(mediaType = "application/json")
            ),
    })
    public ResponseEntity<?> getOfficialCourse(@PathVariable("courseId") Long courseId) {
        OfficialDetailResponseDto course = officialCourseService.getOfficialCourse(courseId);

      return ResponseEntity.ok(course);
    }

    @PatchMapping("/{courseId}")
    @Operation(summary = "공식 코스 참여자 수 갱신", description = "공식 코스 참여자 수 갱신 때 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "공식코스 참여자 수 갱신",
                    content = @Content(mediaType = "application/json")
            ),
    })
    public ResponseEntity<?> incrementCourseCount(@PathVariable("courseId") Long courseId) {
        officialCourseService.incrementCourseCount(courseId);

        return ResponseEntity.ok().build();
    }
}
