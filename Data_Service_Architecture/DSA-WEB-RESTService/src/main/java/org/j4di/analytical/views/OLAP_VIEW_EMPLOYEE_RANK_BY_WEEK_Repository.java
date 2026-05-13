package org.j4di.analytical.views;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK_Repository
        extends JpaRepository<OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK, String> {

    @Query(value = "SELECT * FROM OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK",
            nativeQuery = true)
    List<OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK>
    get_OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK();
}
