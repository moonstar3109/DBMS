-- 랜덤수 뽑기

declare
    --DBMS_RANDOM.value()는 0~10미만 랜덤 실수
    v_num number := round( DBMS_RANDOM.value(0,10) ); --round 0 ~ 10 까지 랜덤수
begin
    DBMS_OUTPUT.PUT_LINE(v_num);
end;

-- IF문

declare
    v_num1 number := 1;
    v_num2 number := 2;
begin
    IF v_num1 > v_num2 THEN
        DBMS_OUTPUT.PUT_LINE(v_num1 || '이 큰 수 ');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_num2||'이 큰 수');
    END IF; --IF구문의 끝
end;


-- ELS IF문
-- employees에서 salary값을 구함
declare
    v_salary number := 0;
    v_department_id number := 0;
begin
    --선언된 변수 값을 변경이 가능
    v_department_id := round( dbms_random.value( 10, 110 ) , -1);
    DBMS_OUTPUT.put_line(v_department_id);
    select salary
    into v_salary
    from employees
    where department_id = v_department_id and rownum = 1; --첫번째 행만 조회
    
    DBMS_OUTPUT.put_line(v_salary);--급여
    
--    if v_salary <= 5000 then
--        DBMS_OUTPUT.put_line('낮음');
--    ELSIF v_salary <= 9000 then
--         DBMS_OUTPUT.put_line('중간');
--    else
--     DBMS_OUTPUT.put_line('높음');
--    end if;   
    case  when v_salary <= 5000 then
        DBMS_OUTPUT.put_line('낮음');
        when v_salary <= 9000 then
        DBMS_OUTPUT.put_line('중간');
        else -- default문
        DBMS_OUTPUT.put_line('높음');
    end case;
end;

-- case구문
