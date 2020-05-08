CREATE OR REPLACE FUNCTION get_total_order_amount
    (i_book_no in number)
    RETURN NUMBER
        
    IS
        v_total_amount NUMBER;
    BEGIN
        SELECT SUM(order_amount)
        INTO v_total_amount
        FROM SAMPLE_BOOK_ORDERS
        WHERE book_no = i_book_no;
        
        return v_total_amount;
    END;