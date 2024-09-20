package chuchu.runnerway.course.model.repository;

import chuchu.runnerway.course.entity.ElasticSearchCourse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;


public interface ElasticSearchCourseRepository extends ElasticsearchRepository<ElasticSearchCourse, Long> {
    Page<ElasticSearchCourse> findByNameOrAddressOrMemberNickname(String name, String address, String memberNickname, Pageable pageable);
}
