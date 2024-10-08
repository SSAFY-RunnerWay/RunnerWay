package chuchu.runnerway.course.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CourseImageDto {
    private Long courseId;
    private String url;
}
