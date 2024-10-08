package chuchu.runnerway.runningRecord.entity;

import chuchu.runnerway.runningRecord.dto.request.RecordRegistRequestDto;
import chuchu.runnerway.runningRecord.dto.request.RecordUpdatePictureRequestDto;
import jakarta.persistence.*;
import lombok.Getter;

@Entity
@Getter
public class PersonalImage {

    public PersonalImage() {
    }

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long recordId;

    @OneToOne(optional = false, fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "record_id")
    private RunningRecord runningRecord;

    @Column(name = "url")
    private String url;



    public void createPersonalImage(RunningRecord runningRecord, RecordRegistRequestDto requestDto) {
        this.runningRecord = runningRecord;
        this.url = requestDto.getPersonalImage().getUrl();
    }

    public void updatePersonalImage(RunningRecord runningRecord, RecordUpdatePictureRequestDto requestDto){
        this.runningRecord = runningRecord;
        this.url = requestDto.getUrl();
    }

}
