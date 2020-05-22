-- 최근 입고된 도서
-- 책번호 순으로 내림차순 정렬했을 때 5번째 책까지 조회하기
select book_no, book_title, book_writer, book_price
from (select book_no, book_title, book_writer, book_price
      from sample_books
      order by book_no desc)
where ROWNUM <= 5;

-- 최근 가입한 사용자
-- 가입일 순으로 내림차순 정렬했을 때 5번째 사용자까지 조회하기
select user_name, user_id, user_email, user_registered_date
from (select user_name, user_id, user_email, user_registered_date
      from sample_book_users
      order by user_registered_date desc)
where ROWNUM <= 5;



select book_no, book_title, book_writer, book_publisher, book_point,
       (select count(*) from sample_book_reviews where book_no = A.book_no) review_cnt,
       book_price, book_discount_price, book_likes, book_stock
from sample_books A
where book_no = 10024;

select b.review_no, a.user_name, b.review_point, b.review_content, b.review_registered_date
from sample_book_users A, sample_book_reviews B
where A.user_id = B.user_id
and book_no = ?;

commit;