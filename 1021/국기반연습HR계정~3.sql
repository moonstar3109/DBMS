--while��

declare
    v_dan number := 3;   --3��
    v_count number := 1;
begin
    --�ݺ����ȿ��� LOOP������ �ݵ�� �����ϴ�.
    while v_count <= 9 -- v_count�� 9���� ������ ����
    loop
    DBMS_OUTPUT.PUT_LINE(v_dan || '*' || v_count||'='||v_dan*v_count);
    
    v_count := v_count+1; --1����
    end loop;
end;

--Ż�⹮
-- EXIT WHEN ����

declare 
    v_count number := 1;
    
begin
    while v_count <= 10
    loop
        DBMS_OUTPUT.PUT_LINE(v_count);
        exit when v_count = 5; --v_count�� 5�� Ż��
        v_count := v_count+1;
    end loop;
end;

--FOR��

declare
    v_dan number := 3;
begin
    for i in 1..9
    loop
         DBMS_OUTPUT.PUT_LINE(v_dan || '*' || i||'='||v_dan*i);
        
    end loop;

end;

-- CONTINUE��
declare
    
begin
    for i in 1..9
    loop
        continue when i = 5; -- i�� 5�϶� pass
        DBMS_OUTPUT.PUT_LINE(i);
    end loop;
end;

--��� �������� ����ϴ� �͸����� �����ϼ���

declare
 
begin   
  for i in 2..9
  loop
   for j  in 1..9
   loop  
   DBMS_OUTPUT.PUT_LINE(i || '*' || j||'='||i*j);
    end loop;
   DBMS_OUTPUT.PUT_LINE('-----------------------------------');
  end loop;
end;




declare
    v_dan number := 2;
    v_num number := 1;
begin
    while v_dan<=9
    loop
    DBMS_OUTPUT.PUT_LINE(v_dan || '*' || v_num||'='||v_dan*v_num);
    v_num := v_num+1;
    if v_num = 9 then
    v_dan := v_dan+1;
    v_num := 1;
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    end if;
    end loop;
end;















