package org.j4di.analytical.views;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import org.hibernate.annotations.Immutable;

@Getter
@Entity
@Immutable
@Table(name = "OLAP_VIEW_REVIEWS_CHANNEL_RATING")
public class OLAP_VIEW_REVIEWS_CHANNEL_RATING {

    @Id
    private String rating;

    private String channel;
    private Long review_count;
    private Double avg_rating;
}
