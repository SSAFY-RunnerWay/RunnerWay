package chuchu.runnerway.runningRecord.entity;

import jakarta.persistence.*;
import lombok.Getter;

@Entity
@Getter
public class PersonalImage {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long recordId;

    @OneToOne(optional = false, fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "record_id")
    private RunningRecord runningRecord;

    @Column(name = "url")
    private String url;

    @Column(name = "path")
    private String path;
}
