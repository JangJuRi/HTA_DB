-- SAMPLE_BOOK_TRIGGER�� ���ο� �ֹ��� �߰��� ������ SAMPLE_BOOK_USERS�� ����Ʈ�� ������Ų��.
CREATE OR REPLACE TRIGGER INCREASE_USER_POINT_TRIGGER
    AFTER
    INSERT ON SAMPLE_BOOK_ORDERS
    FOR EACH ROW
    
    DECLARE
        v_price         sample_book_orders.order_price%type;
        v_amount        sample_book_orders.order_amount%type;
        v_deposit_point sample_book_users.user_point%type;
    
    BEGIN
    
        v_price     := :NEW.order_price;
        v_amount    := :NEW.order_amount;
        v_deposit_point := trunc(v_price*v_amount*0.02);
    
        UPDATE SAMPLE_BOOK_USERS
        SET
            USER_POINT = USER_POINT + v_deposit_point
        WHERE
            USER_ID = :NEW.user_id;
    
    END;