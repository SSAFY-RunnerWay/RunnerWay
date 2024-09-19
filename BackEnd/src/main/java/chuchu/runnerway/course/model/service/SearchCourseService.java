package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.response.SelectAllResponseDto;

public interface SearchCourseService {
    SelectAllResponseDto search(String searchWord, int page, int size);
    void insertCourse();
}
