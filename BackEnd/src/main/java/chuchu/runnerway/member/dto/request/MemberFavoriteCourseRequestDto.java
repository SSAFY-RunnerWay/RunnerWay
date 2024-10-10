package chuchu.runnerway.member.dto.request;

import chuchu.runnerway.member.dto.FavoriteCourseDto;
import java.util.List;
import lombok.Data;

@Data
public class MemberFavoriteCourseRequestDto {
    List<FavoriteCourseDto> favoriteCourses;
}
