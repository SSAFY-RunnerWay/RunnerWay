package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.request.OfficialCoordRequestDto;
import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.mapper.CourseMapper;
import chuchu.runnerway.course.model.repository.OfficialCourseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class OfficialCourseServiceImpl implements OfficialCourseService{

    private final OfficialCourseRepository officialCourseRepository;
    private final CourseMapper courseMapper;

    @Override
    public List<OfficialListResponseDto> findAllOfiicialCourse(double lat, double lng) {
        List<Course> courses = officialCourseRepository.findAll(lat, lng);
        return courseMapper.toOfficialListResponseDtoList(courses);
    }

    @Override
    public OfficialDetailResponseDto getOfficialCourse(Long courseId) {
        Course course = officialCourseRepository.findById(courseId)
                .orElseThrow(NoSuchElementException::new);

        return courseMapper.toOfficialDetailResponseDto(course);
    }
}
