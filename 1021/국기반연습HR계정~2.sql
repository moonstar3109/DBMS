-- ������ �̱�

declare
    --DBMS_RANDOM.value()�� 0~10�̸� ���� �Ǽ�
    v_num number := round( DBMS_RANDOM.value(0,10) ); --round 0 ~ 10 ���� ������
begin
    DBMS_OUTPUT.PUT_LINE(v_num);
end;

-- IF��

declare
    v_num1 number := 1;
    v_num2 number := 2;
begin
    IF v_num1 > v_num2 THEN
        DBMS_OUTPUT.PUT_LINE(v_num1 || '�� ū �� ');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_num2||'�� ū ��');
    END IF; --IF������ ��
end;


-- ELS IF��
-- employees���� salary���� ����
declare
    v_salary number := 0;
    v_department_id number := 0;
begin
    --����� ���� ���� ������ ����
    v_department_id := round( dbms_random.value( 10, 110 ) , -1);
    DBMS_OUTPUT.put_line(v_department_id);
    select salary
    into v_salary
    from employees
    where department_id = v_department_id and rownum = 1; --ù��° �ุ ��ȸ
    
    DBMS_OUTPUT.put_line(v_salary);--�޿�
    
--    if v_salary <= 5000 then
--        DBMS_OUTPUT.put_line('����');
--    ELSIF v_salary <= 9000 then
--         DBMS_OUTPUT.put_line('�߰�');
--    else
--     DBMS_OUTPUT.put_line('����');
--    end if;   
    case  when v_salary <= 5000 then
        DBMS_OUTPUT.put_line('����');
        when v_salary <= 9000 then
        DBMS_OUTPUT.put_line('�߰�');
        else -- default��
        DBMS_OUTPUT.put_line('����');
    end case;
end;

-- case����
