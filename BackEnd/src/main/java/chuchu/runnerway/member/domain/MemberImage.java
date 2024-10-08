package chuchu.runnerway.member.domain;

import static jakarta.persistence.FetchType.*;

import chuchu.runnerway.member.dto.MemberImageDto;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.MapsId;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "member_image")
@Builder
@DynamicInsert
@DynamicUpdate
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberImage {

    @Id
    @Column(name = "member_id")
    private Long memberId;

    @OneToOne(optional = false, fetch = LAZY)
    @MapsId
    @JoinColumn(name = "member_id")
    private Member member;

    @Column(name = "url")
    private String url;


    public void updateMemberImage(MemberImageDto memberImageDto) {
        this.url = memberImageDto.getUrl();
    }
}
