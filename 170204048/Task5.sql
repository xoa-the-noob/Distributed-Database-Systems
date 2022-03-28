SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT ID NUMBER PROMPT "Last 3 digits of my ID : "

DECLARE
    id NUMBER;
    remainder int;
BEGIN
    remainder := 0;
    BEGIN
        id := &id;
        remainder := MOD (id, 2);
    END;
    IF remainder = 1 THEN
        DBMS_OUTPUT.PUT_LINE ('ODD') ;
    ELSIF remainder = 0 THEN
        DBMS_OUTPUT.PUT_LINE ('EVEN');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('invalid');
    END IF;
END;
/