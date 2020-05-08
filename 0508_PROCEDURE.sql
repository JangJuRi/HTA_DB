-- ���� ��ȣ�� �λ���� ���޹޾Ƽ� �� ������ �޿��� �λ��Ű�� ���ν��� �ۼ��ϱ�
CREATE OR REPLACE PROCEDURE update_salary
(i_emp_id in number)
IS
-- ���� ����
--  ����          ������ ������Ÿ��
--               employees�� salary�÷��� ������Ÿ�԰� ������ ������Ÿ������ ���� ����
    v_emp_salary employees.salary%type; -- ����� �޿�
    v_update_rate number(4,2);          -- �޿� �λ��
BEGIN
-- SQL ����, PL/SQL ������ �ۼ�
-- ���޹��� �������̵� �ش��ϴ� ������ �޿��� ��ȸ�Ѵ�.
-- ��ȸ�� ������ �޿��� ������ ������ v_emp_salary�� �����Ѵ�.
    SELECT SALARY
    INTO v_emp_salary
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = I_EMP_ID;
    
-- ������ �޿��� ���� �λ���� �����ϱ�
-- 20000�޷� �̻� 10%, 10000�޷� �̻� 15%, �� �� 20% �λ�
    IF v_emp_salary >= 20000 THEN v_update_rate := 0.1;
    ELSIF v_emp_salary >= 10000 THEN v_update_rate := 0.15;
    ELSE v_update_rate := 0.2;
    END IF;
    
-- �޿��� �λ��Ű��
    UPDATE EMPLOYEES
    SET 
        SALARY = SALARY + TRUNC(SALARY*v_update_rate)
    WHERE
        EMPLOYEE_ID = i_emp_id;
        
-- DB�� ���������� �ݿ���Ű��
    COMMIT;
END;