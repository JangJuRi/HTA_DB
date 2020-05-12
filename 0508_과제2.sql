-- 책 번호에 해당하는 책의 총 구매수량을 반환하는 함수
CREATE OR REPLACE FUNCTION get_total_order_amount
    (i_book_no in number)
    
    -- 반환타입 정의
    RETURN NUMBER
        
IS
    -- 총 구매수량을 저장할 변수
    v_total_amount number;
BEGIN
    -- 총 구매수량을 조회해서 변수에 담기
    select nvl(sum(order_amount), 0)
    into v_total_amount
    from sample_book_orders
    where book_no = i_book_no;
    
    -- 변수에 저장된 값 반환하기
    return v_total_amount;
END;