/*

*/
create table tbl_test(
id number(10),
test varchar2(50)
);

create or replace trigger trg_test
    after delete or update --����, ���� ���� ����
    on tbl_test --������ ���̺�
    for each row --�� �࿡ �� ����
begin
 dbms_output.put_line('Ʈ���� ����');
 END;
 
 insert into tbl_test values(10, 'ȫ�浿'); --Ʈ���� ����x
 insert into tbl_test values(20, 'ȫ����'); --Ʈ���� ����x
update tbl_test set test = '�̼���' where id = 20; --Ʈ���� ���� o
delete from tbl_test where id = 20;
select* from tbl_test;