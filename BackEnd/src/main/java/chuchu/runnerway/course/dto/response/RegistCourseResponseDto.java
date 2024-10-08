package chuchu.runnerway.course.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RegistCourseResponseDto {
    private Long courseId;
    private Boolean check;
}
