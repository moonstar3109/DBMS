/*

*/
create table tbl_test(
id number(10),
test varchar2(50)
);

create or replace trigger trg_test
    after delete or update --삭제, 수정 이후 동장
    on tbl_test --부착할 테이블
    for each row --각 행에 다 적용
begin
 dbms_output.put_line('트리거 실행');
 END;
 
 insert into tbl_test values(10, '홍길동'); --트리거 실행x
 insert into tbl_test values(20, '홍길자'); --트리거 실행x
update tbl_test set test = '이순신' where id = 20; --트리거 실행 o
delete from tbl_test where id = 20;
select* from tbl_test;