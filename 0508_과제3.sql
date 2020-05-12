-- 책 번호에 해당하는 책의 총 판매가격을 반환하는 함수
CREATE OR REPLACE FUNCTION get_total_order_price
    (i_book_no IN number)
    
    RETURN number
IS
    v_total_order_price number;
BEGIN

    -- 총 구매수량 조회하기
    select nvl(sum(order_price * order_amount), 0)
    into v_total_order_price
    from sample_book_orders
    where book_no = i_book_no;
    
    -- 변수에 지정된 값 반환하기
    RETURN v_total_order_price;
END;