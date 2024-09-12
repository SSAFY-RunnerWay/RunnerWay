package chuchu.runnerway.badge.dto.response;

import chuchu.runnerway.badge.dto.BadgeImageDto;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BadgeSelectResponseDto {
    private String name;
    private String content;
    private LocalDateTime getTime;
    BadgeImageDto badgeImage;
}
