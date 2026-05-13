package org.j4di.analytical.views;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY_Repository
        extends JpaRepository<OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY, String> {

    @Query(value = "SELECT * FROM OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY",
            nativeQuery = true)
    List<OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY>
    get_OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY();
}
