package chuchu.runnerway.member.domain;

import chuchu.runnerway.member.dto.request.MemberSignUpRequestDto;
import chuchu.runnerway.member.dto.request.MemberUpdateRequestDto;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import java.time.LocalDateTime;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name = "member")
@DynamicInsert
@DynamicUpdate
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class Member {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id")
    private Long memberId;

    @NotNull
    @Column(name = "email", unique = true)
    private String email;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(name = "join_type")
    private JoinType joinType;

    @NotNull
    @Column(name = "nickname", length = 30, unique = true)
    private String nickname;

    @Column(name = "birth")
    private LocalDate birth;

    @Column(name = "height")
    private Integer height;

    @Column(name = "weight")
    private Integer weight;

    @Column(name = "create_time", columnDefinition = "TIMESTAMP")
    private LocalDateTime createTime;

    @Column(name = "resign_time", columnDefinition = "TIMESTAMP")
    private LocalDateTime resignTime;

    @Column(name = "is_resign")
    @ColumnDefault("0")
    private Integer isResign;

    @OneToOne(mappedBy = "member", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private MemberImage memberImage;

    public void updateMember(MemberUpdateRequestDto memberUpdateRequestDto) {
        this.nickname = memberUpdateRequestDto.getNickname();
        this.birth = memberUpdateRequestDto.getBirth();
        this.height = memberUpdateRequestDto.getHeight();
        this.weight = memberUpdateRequestDto.getWeight();
    }

    public void resign() {
        this.isResign = 1;
    }

    @Builder(builderMethodName = "signupBuilder")
    public Member(MemberSignUpRequestDto memberSignUpRequestDto) {
        this.email = memberSignUpRequestDto.getEmail();
        this.joinType = memberSignUpRequestDto.getJoinType();
        this.nickname = memberSignUpRequestDto.getNickname();
        this.birth = memberSignUpRequestDto.getBirth();
        this.height = memberSignUpRequestDto.getHeight();
        this.weight = memberSignUpRequestDto.getWeight();
    }
}
