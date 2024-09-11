package chuchu.runnerway.member.controller;

import chuchu.runnerway.common.dto.ErrorResponseDto;
import chuchu.runnerway.common.util.MemberInfo;
import chuchu.runnerway.member.dto.request.MemberFavoriteCourseRequestDto;
import chuchu.runnerway.member.dto.request.MemberSignUpRequestDto;
import chuchu.runnerway.member.dto.request.MemberUpdateRequestDto;
import chuchu.runnerway.member.dto.response.MemberSelectResponseDto;
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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

    @PostMapping("/tags")
    @Operation(summary = "회원 선호 정보 등록", description = "회원가입 할 때 사용하는 API")
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "선호 정보 등록에 성공하였습니다!",
            content = @Content(mediaType = "application/json")
        ),
        @ApiResponse(
            responseCode = "500",
            description = "Error Message 로 전달함",
            content = @Content(mediaType = "application/json")
        ),
    })
    public ResponseEntity<?> registFavoriteCourse(
        @RequestBody MemberFavoriteCourseRequestDto memberFavoriteCourseRequestDto
    ) {
        Long memberId = MemberInfo.getId();
        memberService.registFavoriteCourses(memberFavoriteCourseRequestDto, memberId);
        return ResponseEntity.status(HttpStatus.OK).body("선호 정보 등록에 성공하였습니다!");
    }

    @GetMapping
    @Operation(summary = "개인정보 조회", description = "개인정보 조회시 사용하는 API")
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "개인정보 조회 성공",
            content = @Content(mediaType = "application/json")
        )
    })
    public ResponseEntity<MemberSelectResponseDto> selectMember() {
        Long memberId = MemberInfo.getId();
        MemberSelectResponseDto memberSelectResponseDto = memberService.selectMember(memberId);
        return ResponseEntity.status(HttpStatus.OK).body(memberSelectResponseDto);
    }

    @GetMapping("/rankers/{memberId}")
    @Operation(summary = "랭커정보 조회", description = "랭커정보 조회시 사용하는 API")
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "랭커정보 조회 성공",
            content = @Content(mediaType = "application/json")
        )
    })
    public ResponseEntity<MemberSelectResponseDto> selectRanker(@PathVariable("memberId") Long memberId) {
        MemberSelectResponseDto memberSelectResponseDto = memberService.selectMember(memberId);
        return ResponseEntity.status(HttpStatus.OK).body(memberSelectResponseDto);
    }

    @PatchMapping
    @Operation(summary = "회원정보 수정", description = "회원정보 수정 할 때 사용하는 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200",
            description = "닉네임, 프로필 이미지, 생일, 키, 몸무게 변경가능",
            content = @Content(mediaType = "application/json"))
    })
    public ResponseEntity<?> updateMember(
        @RequestBody MemberUpdateRequestDto memberUpdateRequestDto) {
        Long memberId = MemberInfo.getId();
        memberService.updateMember(memberUpdateRequestDto, memberId);
        return ResponseEntity.status(HttpStatus.OK).body("회원정보 수정완료!!");
    }

    @DeleteMapping
    @Operation(summary = "회원 탈퇴", description = "회원탈퇴 할 때 사용하는 API")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200",
            description = "회원 탈퇴 성공",
            content = @Content(mediaType = "application/json"))
    })
    public ResponseEntity<?> resignMember() {
        Long memberId = MemberInfo.getId();
        memberService.resignMember(memberId);
        return ResponseEntity.status(HttpStatus.OK).body("회원 탈퇴 성공");
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
