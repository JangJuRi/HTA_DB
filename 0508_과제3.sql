-- å ��ȣ�� �ش��ϴ� å�� �� �ǸŰ����� ��ȯ�ϴ� �Լ�
CREATE OR REPLACE FUNCTION get_total_order_price
    (i_book_no IN number)
    
    RETURN number
IS
    v_total_order_price number;
BEGIN

    -- �� ���ż��� ��ȸ�ϱ�
    select nvl(sum(order_price * order_amount), 0)
    into v_total_order_price
    from sample_book_orders
    where book_no = i_book_no;
    
    -- ������ ������ �� ��ȯ�ϱ�
    RETURN v_total_order_price;
END;