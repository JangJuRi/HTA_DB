CREATE OR REPLACE PROCEDURE add_book_order
(i_user_id in varchar2,
 i_book_no in number,
 i_book_amount in number)
IS
    v_book_price number;
    v_book_stock number;
    
    -- 사용자정의 예외 이름 선언
    book_application_error exception;
BEGIN
    -- 책의 할인가격, 현재 재고 정보 조회
    SELECT book_discount_price, book_stock
    INTO v_book_price, v_book_stock -- 조회된 컬럼의 값을 변수에 저장
    FROM SAMPLE_BOOKS
    WHERE BOOK_NO = i_book_no;
    
    IF v_book_stock >= i_book_amount then 
        
        -- 주문정보 저장
        INSERT INTO SAMPLE_BOOK_ORDERS
        (ORDER_NO, USER_ID, BOOK_NO, ORDER_PRICE, ORDER_AMOUNT, ORDER_REGISTERED_DATE)
        VALUES
        (SAMPLE_ORDER_SEQ.NEXTVAL, i_user_id, i_book_no, v_book_price, i_book_amount, sysdate);
        
        -- 책의 재고 변경
        UPDATE SAMPLE_BOOKS
        SET
            BOOK_STOCK = BOOK_STOCK - i_book_amount
        WHERE BOOK_NO = i_book_no;
        
        -- 데이터베이스에 반영
        commit; 
    ELSE
        -- 책의 재고가 주문량보다 부족한 경우 예외 발생
        RAISE book_application_error;
    END IF; 
    
    -- 예외처리
    EXCEPTION
        -- 사용자정의 예외가 발생했다면 오라클의 RAISE_APPLICATION_ERROR(예외코드, 에러메세지)를 실행시킨다.
        WHEN book_application_error THEN
            -- 오류코드는 -20000 ~ -20999 사이의 값을 사용한다.
            RAISE_APPLICATION_ERROR(-20000, '재고가 부족합니다.');
end;