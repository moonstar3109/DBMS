/*
오라클의 최고 관리자 계정으로 실행을 시킵니다.
*/

-- 계정 생성명령
create user user01 identified by user01;
--생성 된 계정에 권한 부여
grant create session, create table, create sequence, create view to user01;
--테이블 스페이스 (데이터가 물리적으로 저장되는 공간)
