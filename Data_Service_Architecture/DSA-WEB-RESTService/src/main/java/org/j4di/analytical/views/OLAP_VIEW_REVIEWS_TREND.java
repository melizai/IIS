package org.j4di.analytical.views;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import org.hibernate.annotations.Immutable;

@Getter
@Entity
@Immutable
@Table(name = "OLAP_VIEW_REVIEWS_TREND")
public class OLAP_VIEW_REVIEWS_TREND {

    @Id
    private Integer review_chronological_order;

    private String product_name;
    private String category;
    private Integer rating;
    private String comment;
    private Double running_average_rating;
}
