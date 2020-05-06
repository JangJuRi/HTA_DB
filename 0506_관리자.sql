-- 사용자명 scott
-- 비밀번호 tiger
create user scott IDENTIFIED by tiger;

-- 생성된 사용자에게 데이터베이스 연결 권한 부여하기
grant create session to scott;

-- 일반 사용자가 부여되는 시스템권한을 그룹화 해놓은 룰을 이용해서 권한 부여하기
grant connect, resource to scott;