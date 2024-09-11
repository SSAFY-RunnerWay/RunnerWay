package chuchu.runnerway.course.controller;

import chuchu.runnerway.course.dto.response.UserListResponseDto;
import chuchu.runnerway.course.model.service.UserCourseService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/user-course")
@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserCourseService userCourseService;

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
        List<UserListResponseDto> userCourseList = userCourseService.findAllOfficialCourse(lat, lng);
        return ResponseEntity.status(HttpStatus.OK).body(userCourseList);
    }
}
