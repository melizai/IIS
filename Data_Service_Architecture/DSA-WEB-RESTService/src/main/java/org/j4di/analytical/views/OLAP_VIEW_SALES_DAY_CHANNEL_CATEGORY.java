package org.j4di.analytical.views;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import org.hibernate.annotations.Immutable;

@Getter
@Entity
@Immutable
@Table(name = "OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY")
public class OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY {

    @Id
    private String order_day;

    private String channel;
    private String category;
    private Double sales_amount;
    private Long total_quantity;
}
