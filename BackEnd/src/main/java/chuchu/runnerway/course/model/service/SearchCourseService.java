package chuchu.runnerway.course.model.service;

import chuchu.runnerway.course.dto.response.MatchByWordResponseDto;
import chuchu.runnerway.course.dto.response.SelectAllResponseDto;

import java.util.List;

public interface SearchCourseService {
    SelectAllResponseDto search(String searchWord, int page, int size);
    List<MatchByWordResponseDto> matchByWord(String searchWord);
    void insertCourse();
}
