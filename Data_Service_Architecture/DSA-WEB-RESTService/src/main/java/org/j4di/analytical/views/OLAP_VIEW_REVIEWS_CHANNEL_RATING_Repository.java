package org.j4di.analytical.views;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OLAP_VIEW_REVIEWS_CHANNEL_RATING_Repository
        extends JpaRepository<OLAP_VIEW_REVIEWS_CHANNEL_RATING, String> {

    @Query(value = "SELECT * FROM OLAP_VIEW_REVIEWS_CHANNEL_RATING",
            nativeQuery = true)
    List<OLAP_VIEW_REVIEWS_CHANNEL_RATING>
    get_OLAP_VIEW_REVIEWS_CHANNEL_RATING();
}
