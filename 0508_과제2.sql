-- å ��ȣ�� �ش��ϴ� å�� �� ���ż����� ��ȯ�ϴ� �Լ�
CREATE OR REPLACE FUNCTION get_total_order_amount
    (i_book_no in number)
    
    -- ��ȯŸ�� ����
    RETURN NUMBER
        
IS
    -- �� ���ż����� ������ ����
    v_total_amount number;
BEGIN
    -- �� ���ż����� ��ȸ�ؼ� ������ ���
    select nvl(sum(order_amount), 0)
    into v_total_amount
    from sample_book_orders
    where book_no = i_book_no;
    
    -- ������ ����� �� ��ȯ�ϱ�
    return v_total_amount;
END;