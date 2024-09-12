package chuchu.runnerway.badge.domain;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name = "badge_items")
@DynamicInsert
@DynamicUpdate
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class BadgeItems {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "badge_items_id")
    private Long badgeItemsId;

    @NotNull
    @Column(name = "name")
    private String name;

    @NotNull
    @Column(name = "content", length = 1000)
    private String content;

    @OneToOne(mappedBy = "badgeItems", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private BadgeImage badgeImage;
}
