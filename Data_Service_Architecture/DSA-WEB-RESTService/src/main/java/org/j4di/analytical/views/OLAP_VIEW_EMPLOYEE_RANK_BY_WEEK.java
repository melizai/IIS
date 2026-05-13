package org.j4di.analytical.views;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import org.hibernate.annotations.Immutable;

@Getter
@Entity
@Immutable
@Table(name = "OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK")
public class OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK {

    @Id
    private String fullName;

    private Integer week_no;
    private String week_start;
    private String week_end;
    private Double sales_amount;
    private Integer rank_in_week;
}
