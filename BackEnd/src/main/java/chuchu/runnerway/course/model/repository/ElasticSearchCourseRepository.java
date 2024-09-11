package chuchu.runnerway.course.model.repository;

import chuchu.runnerway.course.entity.ElasticSearchCourse;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface ElasticSearchCourseRepository extends ElasticsearchRepository<ElasticSearchCourse, Long> {

}
