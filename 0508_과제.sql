CREATE OR REPLACE PROCEDURE add_book_order
(i_user_id in varchar2,
 i_book_no in number,
 i_book_amount in number)
IS
    v_book_price number;
    v_book_stock number;
BEGIN
    SELECT book_discount_price, book_stock
    INTO v_book_price, v_book_stock
    FROM SAMPLE_BOOKS
    WHERE BOOK_NO = i_book_no;
    
    IF v_book_stock >= i_book_amount then 
        
        INSERT INTO SAMPLE_BOOK_ORDERS
        (ORDER_NO, USER_ID, BOOK_NO, ORDER_PRICE, ORDER_AMOUNT)
        VALUES
        (SAMPLE_ORDER_SEQ.NEXTVAL, i_user_id, i_book_no, v_book_price, i_book_amount);
        
        UPDATE SAMPLE_BOOKS
        SET
            BOOK_STOCK = BOOK_STOCK - i_book_amount
        WHERE BOOK_NO = i_book_no;
        
    END IF;
    
    commit;
    
end;