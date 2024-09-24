package chuchu.runnerway.course.controller;

import chuchu.runnerway.course.dto.request.UserCourseRegistRequestDto;
import chuchu.runnerway.course.dto.response.UserDetailResponseDto;
import chuchu.runnerway.course.dto.response.UserListResponseDto;
import chuchu.runnerway.course.model.service.IncrementCountService;
import chuchu.runnerway.course.model.service.UserCourseService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/user-course")
@RestController
@RequiredArgsConstructor
public class UserCourseController {

    private final UserCourseService userCourseService;
    private final IncrementCountService incrementCountService;

    @GetMapping("/list")
    @Operation(summary = "유저 코스 목록 조회", description = "유저 코스 목록 조회시 사용하는 API")
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "유저 코스 목록 조회 성공",
            content = @Content(mediaType = "application/json")
        )
    })
    public ResponseEntity<?> selectUserCourseList(@RequestParam Double lat, @RequestParam Double lng) {
        List<UserListResponseDto> userCourseList = userCourseService.findAllUserCourse(lat, lng);
        return ResponseEntity.status(HttpStatus.OK).body(userCourseList);
    }

    @GetMapping("/detail/{courseId}")
    @Operation(summary = "유저 코스 상세 조회", description = "유저 코스 상세 조회시 사용하는 API")
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "유저 코스 상세 조회 성공",
            content = @Content(mediaType = "application/json")
        )
    })
    public ResponseEntity<?> getUserCourse(@PathVariable("courseId") Long courseId) {
        UserDetailResponseDto course = userCourseService.getUserCourse(courseId);
        return ResponseEntity.ok(course);
    }

    @GetMapping("/popularity/all")
    @Operation(summary = "전체 인기 유저 코스 조회", description = "전체 인기 유저 코스 조회시 사용하는 API")
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "전체 인기 유저 코스 조회 성공",
            content = @Content(mediaType = "application/json")
        )
    })
    public ResponseEntity<?> selectPopularAllList(@RequestParam Double lat, @RequestParam Double lng) {
        List<UserListResponseDto> userCourseList = userCourseService.findPopularAllUserCourse(lat, lng);
        return ResponseEntity.ok(userCourseList);
    }

    @GetMapping("/popularity/lately")
    @Operation(summary = "최근 인기 유저 코스 조회", description = "최근 인기 유저 코스 조회시 사용하는 API")
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "최근 인기 유저 코스 조회 성공",
            content = @Content(mediaType = "application/json")
        )
    })
    public ResponseEntity<?> selectPopularLatelyList(@RequestParam Double lat, @RequestParam Double lng) {
        List<UserListResponseDto> userCourseList = userCourseService.findPopularLatelyUserCourse(lat, lng);
        return ResponseEntity.ok(userCourseList);
    }

    @PostMapping
    @Operation(summary = "유저 코스 등록", description = "유저 코스 등록 API")
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "유저 코스 등록 성공",
            content = @Content(mediaType = "application/json")
        )
    })
    public ResponseEntity<?> registUserCourse(
        @RequestBody UserCourseRegistRequestDto userCourseRegistRequestDto
    ) {
        userCourseService.registUserCourse(userCourseRegistRequestDto);
        return ResponseEntity.ok("유저 코스 등록 성공");
    }

    @PatchMapping("/{courseId}")
    @Operation(summary = "유저 코스 참여자 수 갱신", description = "유저 코스 참여자 수 갱신 때 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "유저 코스 참여자 수 갱신",
                    content = @Content(mediaType = "application/json")
            ),
    })
    public ResponseEntity<?> incrementCourseCount(@PathVariable("courseId") Long courseId) {
        incrementCountService.incrementUserCourseCount(courseId);

        return ResponseEntity.ok("코스 참여가 등록되었습니다.");
    }
}
