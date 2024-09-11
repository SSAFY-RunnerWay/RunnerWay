package chuchu.runnerway.course.dto.request;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
public class OfficialCoordRequestDto {

    private double lat;
    private double lng;

}
