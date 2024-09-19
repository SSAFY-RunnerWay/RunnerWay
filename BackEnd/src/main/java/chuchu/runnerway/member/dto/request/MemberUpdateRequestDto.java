package chuchu.runnerway.member.dto.request;

import chuchu.runnerway.member.dto.MemberImageDto;
import java.time.LocalDate;
import lombok.Data;

@Data
public class MemberUpdateRequestDto {
    private String nickname;
    private LocalDate birth;
    private Integer height;
    private Integer weight;
    private MemberImageDto memberImage;
}
