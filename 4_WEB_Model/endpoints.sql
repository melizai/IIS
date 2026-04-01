BEGIN 
ORDS.ENABLE_SCHEMA(
p_enabled => FALSE);
 ORDS.drop_rest_for_schema();
 COMMIT; 
END; 


BEGIN
    ORDS.DEFINE_MODULE(
        p_module_name    => 'analytics_api',
        p_base_path      => '/analytics/',
        p_items_per_page => 25
    );
    COMMIT;
END;



BEGIN
    ORDS.DEFINE_TEMPLATE(
        p_module_name => 'analytics_api',
        p_pattern     => 'sales'
    );
END;


BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'analytics_api',
        p_pattern     => 'sales',
        p_method      => 'GET',
        p_source_type => ORDS.source_type_query,
        p_source      => '
            SELECT *
            FROM OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY
            WHERE (:channel IS NULL OR channel = :channel)
              AND (:category IS NULL OR category = :category)
        '
    );
    COMMIT;
END;



BEGIN
    ORDS.DEFINE_TEMPLATE(
        p_module_name => 'analytics_api',
        p_pattern     => 'reviews_trend'
    );
END;


BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'analytics_api',
        p_pattern     => 'reviews_trend',
        p_method      => 'GET',
        p_source_type => ORDS.source_type_query,
        p_source      => '
            SELECT *
            FROM OLAP_VIEW_REVIEWS_TREND
            WHERE (:category IS NULL OR category = :category)
        '
    );
    COMMIT;
END;



BEGIN
    ORDS.DEFINE_TEMPLATE(
        p_module_name => 'analytics_api',
        p_pattern     => 'reviews_channel_rating'
    );
END;


BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'analytics_api',
        p_pattern     => 'reviews_channel_rating',
        p_method      => 'GET',
        p_source_type => ORDS.source_type_query,
        p_source      => '
            SELECT *
            FROM OLAP_VIEW_REVIEWS_CHANNEL_RATING
            WHERE (:channel IS NULL OR channel = :channel)
        '
    );
    COMMIT;
END;



BEGIN
    ORDS.DEFINE_TEMPLATE(
        p_module_name => 'analytics_api',
        p_pattern     => 'employee_rank'
    );
END;


BEGIN
    ORDS.DEFINE_HANDLER(
        p_module_name => 'analytics_api',
        p_pattern     => 'employee_rank',
        p_method      => 'GET',
        p_source_type => ORDS.source_type_query,
        p_source      => '
            SELECT *
            FROM OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK
            WHERE (:week_no IS NULL OR week_no = :week_no)
        '
    );
    COMMIT;
END;
