package chuchu.runnerway.member.controller;

import chuchu.runnerway.common.dto.ErrorResponseDto;
import chuchu.runnerway.member.dto.request.MemberSignUpRequestDto;
import chuchu.runnerway.member.exception.MemberDuplicateException;
import chuchu.runnerway.member.exception.NotFoundMemberException;
import chuchu.runnerway.member.exception.ResignedMemberException;
import chuchu.runnerway.member.service.MemberService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/members")
@RestController
@RequiredArgsConstructor
public class MemberController {

    private final MemberService memberService;

    @PostMapping("/sign-up")
    @Operation(summary = "회원가입", description = "회원가입 할 때 사용하는 API")
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "회원가입에 성공하였습니다!",
            content = @Content(mediaType = "application/json")
        ),
        @ApiResponse(
            responseCode = "500",
            description = "Error Message 로 전달함",
            content = @Content(mediaType = "application/json")
        ),
    })
    public ResponseEntity<?> signUp(
        @RequestBody MemberSignUpRequestDto memberSignUpRequestDto
    ) {
        String accessToken = memberService.signUp(memberSignUpRequestDto);
        return ResponseEntity.status(HttpStatus.OK).body(accessToken);
    }

    @ExceptionHandler({MemberDuplicateException.class, NotFoundMemberException.class,
        ResignedMemberException.class})
    public ResponseEntity<?> memberDuplicateException(Exception e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
            .contentType(MediaType.APPLICATION_JSON)
            .body(new ErrorResponseDto(
                    HttpStatus.INTERNAL_SERVER_ERROR.value(),
                    e.getMessage(),
                    LocalDateTime.now()
                )
            );
    }
}
