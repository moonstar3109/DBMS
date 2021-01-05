/*
after - insert, update, delete 작업 이후에 동작하는 트리거 입니다.
before - insert, update, delete 작업 이전에 동작하는 트리거 입니다.
instead of - insert, update, delete 작업 이전에 view에만 부작되서 실행되는 트리거 입니다.

:OLD = 참조 전 열 값 (update : 수정하기 전 데이터 / delete : 삭제하기 전 데이터)
:NEW = 참조 후 열 값 (insert : 입력할 자료 / update : 수정 된 자료)


*/

--예를 들어, 회원에 테이블 update, delete 작업이 수행되면, 이력을 남겨놓는다.
create table tbl_user(
    id varchar2(50) primary key,
    name varchar2(50),
    address varchar2(50)
);

create table tbl_user_backup(
    id varchar2(50),
    name varchar2(50),
    address varchar2(50),
    updatedate date default sysdate,
    m_type char(1), --변견될 타입
    m_user varchar2(50) --변경한 사용자
);

--after트리거 -
create or replace trigger trg_user_backup
    after update or delete
    on tbl_user--부착테이블
    for each row
declare --변수선언
    v_type char(1);
begin --실행블록
    if updating then --update 수정 되었다는 시스템 변수
    v_type := 'U';
    elsif deleting then --deleting 삭제되었다는 시스템 변수
    v_type := 'D';
    end if;
    -- :old.컬럼 - 테이블에 변경 전 데이터를 의미함
    --user() 접속되어있는 계정
    
    insert into tbl_user_backup values(:old.id , :old.name, :old.address, sysdate, v_type, user() );
    
end;
--트리거확인 
insert into tbl_user values('test01','홍길동', '서울');
insert into tbl_user values('test02','홍길자', '부산');
insert into tbl_user values('test03','이순신', '경기');

update tbl_user set address = '제주' where id = 'test01';
delete from tbl_user where id = 'test01';
select * from tbl_user_backup;

--before트리거 -테이블에 DML구문 실행 전
--예를 들어 insert 되기 전에, 데이터를 변경하는 형태.

create or replace trigger trg_user_insert
    before insert
    on tbl_user
    for each row
declare
begin
    --:new.컬럼 - insert구문에서 전달되는 데이터.
    :new.name := substr(:new.name , 1,1)||'**'; -- ex)김**
end;
insert into tbl_user values('test04','이방원', '부산');
insert into tbl_user values('test05','이성계', '경기');

select* from tbl_user;



---------------------------------------트리거 활용--------------------------------
--주문상세 테이블에 insert(주문상세 after trigger) -> 물품테이블 update 시킴

--주문상세 테이블
create sequence order_history_seq nocache; --주문상세 시퀀스
create table order_history(
    history_no number(5) primary key,
    order_no number(5), --FK 주문번호
    product_no number(5), --FK 상품번호
    total number(10), --수량
    price number(10)
);

--상품테이블
create sequence product_seq nocache;
create table product(
    product_no number(5) primary key,
    product_name varchar2(30),
    total number(10),
    price number(10)
);

insert into product values(product_seq.nextval, '피자',100,10000);
insert into product values(product_seq.nextval, '치킨',100,15000);
insert into product values(product_seq.nextval, '햄버거',100,5000);

select * from product;


--주문 상세에 insert가 들어오면 실행 trigger

create or replace trigger trg_order_history_insert
    after insert
    on order_history
    for each row
declare
    v_total number; --개수
    v_product_no number; --상품번호
begin
    select :new.total, :new.product_no
        into v_total, v_product_no
        from dual; --가상테이블
        
    --상품에서 업데이트.
    update product set total = total - v_total --현재 상품 토탈 - 전달되는 개수
    where product_no = v_product_no;
           
end;

--확인
insert into order_history values(order_history_seq.nextval, 50000,1,10,10000); --피자 10개 주문
insert into order_histroy values(order_history_seq.nextval, 50000,2,5,15000); --치킨 5개 주문
insert into order_history values(order_history_seq.nextval, 50000,3,1, 5000); --햄버거 1개 주문

desc order_history;