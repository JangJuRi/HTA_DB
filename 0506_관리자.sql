-- ����ڸ� scott
-- ��й�ȣ tiger
create user scott IDENTIFIED by tiger;

-- ������ ����ڿ��� �����ͺ��̽� ���� ���� �ο��ϱ�
grant create session to scott;

-- �Ϲ� ����ڰ� �ο��Ǵ� �ý��۱����� �׷�ȭ �س��� ���� �̿��ؼ� ���� �ο��ϱ�
grant connect, resource to scott;