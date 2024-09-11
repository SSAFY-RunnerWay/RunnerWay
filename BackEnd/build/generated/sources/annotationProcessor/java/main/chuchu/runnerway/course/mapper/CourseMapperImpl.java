package chuchu.runnerway.course.mapper;

import chuchu.runnerway.course.dto.response.OfficialDetailResponseDto;
import chuchu.runnerway.course.dto.response.OfficialListResponseDto;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.entity.CourseImage;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2024-09-11T09:05:05+0900",
    comments = "version: 1.5.3.Final, compiler: IncrementalProcessingEnvironment from gradle-language-java-8.10.jar, environment: Java 17.0.11 (Eclipse Adoptium)"
)
@Component
public class CourseMapperImpl implements CourseMapper {

    @Override
    public OfficialDetailResponseDto toOfficialDetailResponseDto(Course course) {
        if ( course == null ) {
            return null;
        }

        OfficialDetailResponseDto officialDetailResponseDto = new OfficialDetailResponseDto();

        officialDetailResponseDto.setUrl( courseCourseImageUrl( course ) );
        officialDetailResponseDto.setCourseId( course.getCourseId() );
        officialDetailResponseDto.setName( course.getName() );
        officialDetailResponseDto.setAddress( course.getAddress() );
        officialDetailResponseDto.setContent( course.getContent() );
        officialDetailResponseDto.setCount( course.getCount() );
        officialDetailResponseDto.setLevel( course.getLevel() );
        officialDetailResponseDto.setAverageSlope( course.getAverageSlope() );
        officialDetailResponseDto.setAverageTime( course.getAverageTime() );
        officialDetailResponseDto.setCourseLength( course.getCourseLength() );
        officialDetailResponseDto.setAverageCalorie( course.getAverageCalorie() );

        return officialDetailResponseDto;
    }

    @Override
    public OfficialListResponseDto toOfficialListResponseDto(Course course) {
        if ( course == null ) {
            return null;
        }

        OfficialListResponseDto officialListResponseDto = new OfficialListResponseDto();

        officialListResponseDto.setUrl( courseCourseImageUrl( course ) );
        officialListResponseDto.setCourseId( course.getCourseId() );
        officialListResponseDto.setName( course.getName() );
        officialListResponseDto.setAddress( course.getAddress() );
        officialListResponseDto.setCount( course.getCount() );
        officialListResponseDto.setLevel( course.getLevel() );
        officialListResponseDto.setCourseLength( course.getCourseLength() );

        return officialListResponseDto;
    }

    @Override
    public List<OfficialListResponseDto> toOfficialListResponseDtoList(List<Course> courses) {
        if ( courses == null ) {
            return null;
        }

        List<OfficialListResponseDto> list = new ArrayList<OfficialListResponseDto>( courses.size() );
        for ( Course course : courses ) {
            list.add( toOfficialListResponseDto( course ) );
        }

        return list;
    }

    private String courseCourseImageUrl(Course course) {
        if ( course == null ) {
            return null;
        }
        CourseImage courseImage = course.getCourseImage();
        if ( courseImage == null ) {
            return null;
        }
        String url = courseImage.getUrl();
        if ( url == null ) {
            return null;
        }
        return url;
    }
}
