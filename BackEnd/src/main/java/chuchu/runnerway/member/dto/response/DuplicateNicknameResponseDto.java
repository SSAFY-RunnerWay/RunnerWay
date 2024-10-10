package chuchu.runnerway.member.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class DuplicateNicknameResponseDto {
    Boolean duplicateResult;
}
