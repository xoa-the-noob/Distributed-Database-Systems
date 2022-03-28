SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER F1
AFTER INSERT 
ON Students
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('F1');
END;
/

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER F2 
BEFORE INSERT 
ON Students
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('F2');
END;
/

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER F3 
AFTER INSERT OR DELETE 
ON Students
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('F3');
END;
/

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER F4
AFTER UPDATE OF CGPA 
ON Students
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('F4');
END;
/

SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER F5 
AFTER UPDATE OF CGPA
ON Students
FOR EACH ROW
WHEN (OLD.name not like '%Fring')
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('F5');
END;
/