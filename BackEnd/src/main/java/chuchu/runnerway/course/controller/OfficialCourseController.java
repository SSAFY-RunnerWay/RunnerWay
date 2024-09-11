package chuchu.runnerway.course.controller;

import chuchu.runnerway.course.dto.request.OfficialCoordRequestDto;
import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.model.service.OfficialCourseService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/officialCourse")
@RequiredArgsConstructor
@Slf4j
public class OfficialCourseController {

    private final OfficialCourseService officialCourseService;

    @GetMapping("/list")
    public ResponseEntity<?> findAllOfficialCourses(@RequestParam double lat, @RequestParam double lng) {
        List<OfficialListResponseDto> courses = officialCourseService.findAllOfiicialCourse(lat, lng);
        return ResponseEntity.ok(courses);
    }

    @GetMapping("/detail/{courseId}")
    public ResponseEntity<?> getOfficialCourse(@PathVariable("courseId") Long courseId) {
        OfficialDetailResponseDto course = officialCourseService.getOfficialCourse(courseId);
        System.out.println();
      return ResponseEntity.ok(course);
    }
}
