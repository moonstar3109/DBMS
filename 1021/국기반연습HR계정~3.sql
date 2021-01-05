--while문

declare
    v_dan number := 3;   --3단
    v_count number := 1;
begin
    --반복문안에는 LOOP구문을 반드시 적습니다.
    while v_count <= 9 -- v_count가 9보다 작으면 실행
    loop
    DBMS_OUTPUT.PUT_LINE(v_dan || '*' || v_count||'='||v_dan*v_count);
    
    v_count := v_count+1; --1증가
    end loop;
end;

--탈출문
-- EXIT WHEN 조건

declare 
    v_count number := 1;
    
begin
    while v_count <= 10
    loop
        DBMS_OUTPUT.PUT_LINE(v_count);
        exit when v_count = 5; --v_count가 5면 탈출
        v_count := v_count+1;
    end loop;
end;

--FOR문

declare
    v_dan number := 3;
begin
    for i in 1..9
    loop
         DBMS_OUTPUT.PUT_LINE(v_dan || '*' || i||'='||v_dan*i);
        
    end loop;

end;

-- CONTINUE문
declare
    
begin
    for i in 1..9
    loop
        continue when i = 5; -- i가 5일때 pass
        DBMS_OUTPUT.PUT_LINE(i);
    end loop;
end;

--모든 구구단을 출력하는 익명블록을 생성하세요

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















