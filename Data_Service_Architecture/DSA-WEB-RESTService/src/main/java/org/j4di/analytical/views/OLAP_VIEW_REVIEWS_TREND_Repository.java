package org.j4di.analytical.views;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OLAP_VIEW_REVIEWS_TREND_Repository
        extends JpaRepository<OLAP_VIEW_REVIEWS_TREND, Integer> {

    @Query(value = "SELECT * FROM OLAP_VIEW_REVIEWS_TREND",
            nativeQuery = true)
    List<OLAP_VIEW_REVIEWS_TREND>
    get_OLAP_VIEW_REVIEWS_TREND();
}
