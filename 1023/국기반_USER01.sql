create table member(
    id varchar2(30) primary key,
    pw varchar2(30),
    name varchar2(30),
    email varchar2(30)
);

insert into member values('test01','1234','ȫ�浿','naver');
insert into member values ('test02','1234','�̼���','naver');
insert into member values ('test03','1234','ȫ����','google');

commit;
