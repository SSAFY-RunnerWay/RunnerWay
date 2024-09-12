package chuchu.runnerway.badge.dto.response;

import chuchu.runnerway.badge.dto.BadgeDto;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BadgesSelectResponseDto {
    List<BadgeDto> myBadgeList;
}
