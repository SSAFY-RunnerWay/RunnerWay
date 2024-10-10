package chuchu.runnerway.badge.domain;

import static jakarta.persistence.FetchType.LAZY;

import chuchu.runnerway.badge.dto.BadgeImageDto;
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
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name = "badge_image")
@Builder
@DynamicInsert
@DynamicUpdate
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class BadgeImage {

    @Id
    @Column(name = "badge_items_id")
    private Long badgeItemsId;

    @OneToOne(optional = false, fetch = LAZY)
    @MapsId
    @JoinColumn(name = "badge_items_id")
    private BadgeItems badgeItems;

    @Column(name = "url")
    private String url;

    public void updateBadgeImage(BadgeImageDto badgeImageDto) {
        this.url = badgeImageDto.getUrl();
    }
}
