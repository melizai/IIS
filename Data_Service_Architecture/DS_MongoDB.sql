--------------------------------------------------------------------------------
--- MongoDB Views: reviews
--------------------------------------------------------------------------------
SELECT java_method(
     'org.spark.service.rest.RESTEnabledSQLService',
     'createJSONViewFromREST',
     'REVIEWS_JSON_VIEW',
     'http://localhost:8093/DSA-NoSQL-MongoDBService/rest/restaurant/ReviewView'
);
SELECT * FROM REVIEWS_JSON_VIEW;
-- DROP VIEW reviews_view;
CREATE OR REPLACE VIEW reviews_view AS
SELECT
  v.orderId,
  v.menuItemId,
  v.rating,
  v.comment
FROM REVIEWS_JSON_VIEW AS json_view
LATERAL VIEW explode(json_view.array) AS v;
SELECT * FROM reviews_view;
