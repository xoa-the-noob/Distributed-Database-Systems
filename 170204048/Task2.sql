SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
X varchar2(100) := '&Given';
i NUMBER;
l NUMBER;
res NUMBER := 0;
digit CHAR(1);
S1 varchar2(100);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Return:');
    l := length(X);
        FOR i in 0..l-1 LOOP
            digit := SUBSTR(X, l-i, 1);		
			IF digit = 'A' THEN
				DBMS_OUTPUT.PUT_LINE('T');
			ELSIF digit = 'T' THEN
			    DBMS_OUTPUT.PUT_LINE('A');
			ELSIF  digit = 'G' THEN
                DBMS_OUTPUT.PUT_LINE('C');
			ELSIF  digit = 'C' THEN
                DBMS_OUTPUT.PUT_LINE('G');
			ELSE 
				DBMS_OUTPUT.PUT_LINE('invalid');
				EXIT;
			END IF;  
		END LOOP;
END;
/


SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
S varchar2(100) := '&S';
T varchar2(100) := '&T';
j NUMBER;
l1 NUMBER;
digit1 CHAR(1);
digit2 CHAR(1);
dis int := 0;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Return:');
    l1 := length(S);
        FOR j in 1..l1 LOOP
            digit1 := SUBSTR(S, j, 1);		
			digit2 := SUBSTR(T, j, 1);		
			IF digit1 != digit2 THEN
			    dis := dis + 1;
			END IF;  
		END LOOP;
		DBMS_OUTPUT.PUT_LINE(dis);
END;
/