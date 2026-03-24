--restheart

CREATE OR REPLACE FUNCTION get_restheart_data_media(pURL VARCHAR2, pUserPass VARCHAR2)
RETURN CLOB IS
  l_req    UTL_HTTP.req;
  l_resp   UTL_HTTP.resp;
  l_buffer CLOB;
BEGIN
  l_req := UTL_HTTP.begin_request(pURL);
  UTL_HTTP.set_header(
    l_req,
    'Authorization',
    'Basic ' ||
    UTL_RAW.cast_to_varchar2(
      UTL_ENCODE.base64_encode(
        UTL_I18N.string_to_raw(pUserPass, 'AL32UTF8')
      )
    )
  );

  l_resp := UTL_HTTP.get_response(l_req);
  UTL_HTTP.READ_TEXT(l_resp, l_buffer);
  UTL_HTTP.end_response(l_resp);

  RETURN l_buffer;
END;

--tests

SELECT get_restheart_data_media(
         'http://host.docker.internal:8081/reviews',
         'admin:secret'
       )
FROM dual;


SELECT HTTPURITYPE.createuri(
         'http://admin:secret@host.docker.internal:8081/restaurant_db/reviews'
       ).getclob() AS doc
FROM dual;


--create views

BEGIN
 EXECUTE IMMEDIATE 'DROP VIEW reviews_view_mongodb';
EXCEPTION
 WHEN OTHERS THEN NULL;
END;

CREATE OR REPLACE VIEW reviews_view_mongodb AS
WITH json AS (
    SELECT get_restheart_data_media(
             'http://host.docker.internal:8081/restaurant_db/reviews',
             'admin:secret'
           ) AS doc
    FROM dual
)
SELECT
    orderId,
    menuItemId,
    rating,
    review_comment,
    (
      TO_TIMESTAMP('1970-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
      + NUMTODSINTERVAL(createdAt_ms / 1000, 'SECOND')
    ) AS createdAt
FROM JSON_TABLE(
    (SELECT doc FROM json),
    '$[*]'
    COLUMNS (
        orderId         NUMBER         PATH '$.orderId'               NULL ON ERROR,
        menuItemId      NUMBER         PATH '$.menuItemId'            NULL ON ERROR,
        rating          NUMBER         PATH '$.rating'                NULL ON ERROR,
        review_comment  VARCHAR2(4000) PATH '$.comment'               NULL ON ERROR,
        createdAt_ms    NUMBER         PATH '$.createdAt."$date"'     NULL ON ERROR
    )
);


--test:

SELECT * FROM reviews_view_mongodb;






