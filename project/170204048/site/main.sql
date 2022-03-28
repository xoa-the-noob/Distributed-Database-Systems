clear screen;
drop TABLE operations1;
CREATE TABLE operations1(opnum number, operationtype varchar2(20), iptype varchar2(20), optype varchar2(20) );
SELECT * from operations1;

INSERT into operations1 values(1,'conversion','octal','binary');
INSERT into operations1 values(2,'conversion','decimal','binary');
INSERT into operations1 values(3,'conversion','hexa','binary');

INSERT into operations1 values(4,'conversion','binary','octal');
INSERT into operations1 values(5,'conversion','decimal','octal');
INSERT into operations1 values(6,'conversion','hexa','octal');

INSERT into operations1 values(7,'conversion','binary','decimal');
INSERT into operations1 values(8,'conversion','octal','decimal');
INSERT into operations1 values(9,'conversion','hexa','decimal');

INSERT into operations1 values(10,'conversion','binary','hexa');
INSERT into operations1 values(11,'conversion','octal','hexa');
INSERT into operations1 values(12,'conversion','decimal','hexa');

SELECT * from operations1;

commit;

SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER OK 
AFTER INSERT 
ON Records1
DECLARE
BEGIN
	DBMS_OUTPUT.PUT_LINE('New entry stored in records table');
END;
/

CREATE OR REPLACE TRIGGER AUTO_INCREMENT
BEFORE INSERT ON Records1
FOR EACH ROW
BEGIN
    SELECT SEQ1.NEXTVAL
    INTO :NEW.recnum
    FROM DUAL;
END;
/


SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
  A operations1.opnum%TYPE;
  B operations1.operationtype%TYPE;
  C operations1.iptype%TYPE;
  D operations1.optype%TYPE;
  
BEGIN
    DBMS_OUTPUT.PUT_LINE('Operation list :');
	DBMS_OUTPUT.PUT_LINE('Sl No.' || '     ' || 'Operation Type' || '     ' || 'Input type' || '     ' || 'Output type');
	FOR R IN (SELECT * FROM operations1) LOOP
		A := R.opnum;
        B := R.operationtype;
        C := R.iptype;
        D := R.optype;
		DBMS_OUTPUT.PUT_LINE(A || '           ' || B || '           ' || C || '           ' || D);
	END LOOP;
END;
/

SET VERIFY OFF;
SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE mypack AS

	FUNCTION DecimalToBinary(A1 IN NUMBER)
	RETURN NUMBER;
	FUNCTION DecimalToOctal(B1 IN NUMBER)
	RETURN NUMBER;
	FUNCTION DecimalToHexa(C1 IN NUMBER)
	RETURN NUMBER;
	FUNCTION BinaryToDecimal(D1 in char)
	RETURN NUMBER;
	FUNCTION OctalToDecimal(E1 in char)
	RETURN NUMBER;
	FUNCTION HexaToDecimal(F1 in char)
	RETURN NUMBER;
	
	PROCEDURE PerformOperations(P IN NUMBER,Y IN varchar);
	
END mypack;
/

CREATE OR REPLACE PACKAGE BODY mypack AS

	FUNCTION DecimalToBinary(A1 IN NUMBER)
	RETURN NUMBER
	IS
	rem NUMBER;
    inputs NUMBER;
    i NUMBER  := 0;
    res NUMBER  := 0;
	BEGIN
		inputs := A1; 
        WHILE inputs > 0 LOOP
		    rem := MOD( inputs, 2 );      
            inputs := TRUNC(inputs/2);     
            res := TO_NUMBER(rem * power(10,i) + res);       
            i:= i+1;
        END LOOP;
        RETURN(res);		
	END DecimalToBinary;
	
	
	FUNCTION DecimalToOctal(B1 IN NUMBER)
	RETURN NUMBER
	IS 
	rem NUMBER;
    inputs NUMBER;
    i NUMBER  := 0;
    res NUMBER  := 0;
	BEGIN
		inputs := B1; 
        WHILE inputs > 0 LOOP
		    rem := MOD( inputs, 8 );      
            inputs := TRUNC(inputs/8);     
            res := TO_NUMBER(rem * power(10,i) + res);       
            i:= i+1;
        END LOOP;
        RETURN(res);		
	END DecimalToOctal;
	
	
	FUNCTION DecimalToHexa(C1 IN NUMBER)
	RETURN NUMBER
	IS 
	rem NUMBER;
    inputs NUMBER;
    i NUMBER  := 0;
    res NUMBER  := 0;
	BEGIN
		inputs := C1; 
        WHILE inputs > 0 LOOP
		    rem := MOD( inputs, 16 );      
            inputs := TRUNC(inputs/16);     
            res := TO_NUMBER(rem * power(10,i) + res);       
            i:= i+1;
        END LOOP;
        RETURN(res);		
	END DecimalToHexa;


    FUNCTION BinaryToDecimal(D1 in CHAR)
    RETURN NUMBER 
	IS
    i NUMBER;
    l NUMBER;
    res NUMBER := 0;
    digit CHAR(1);
    digit2 NUMBER;
    BEGIN
        l := length(D1);
        FOR i in 0..l-1 LOOP
            digit := SUBSTR(D1, l-i, 1);
            digit2 := to_number(digit);
            res := res + (digit2*POWER(2,i));
        END LOOP;
        RETURN res;
    END BinaryToDecimal;

    FUNCTION OctalToDecimal(E1 in CHAR)
	RETURN NUMBER 
	IS
    i NUMBER;
    l NUMBER;
    res NUMBER := 0;
    digit CHAR(1);
    digit2 NUMBER;
    BEGIN
        l := length(E1);
        FOR i in 0..l-1 LOOP
            digit := SUBSTR(E1, l-i, 1);
            digit2 := to_number(digit);
            res := res + (digit2*POWER(8,i));
        END LOOP;
        RETURN res;
    END OctalToDecimal;

    FUNCTION HexaToDecimal(F1 in CHAR)
	RETURN NUMBER 
	IS
    i NUMBER;
    l NUMBER;
    res NUMBER := 0;
    digit CHAR(1);
    digit2 NUMBER;
    BEGIN
        l := length(F1);
        FOR i in 0..l-1 LOOP
            digit := SUBSTR(F1, l-i, 1);
            digit2 := to_number(digit);
            res := res + (digit2*POWER(16,i));
        END LOOP;
        RETURN res;
    END HexaToDecimal;

    PROCEDURE PerformOperations(P IN NUMBER,Y IN varchar)
	IS
	N NUMBER;
	temp NUMBER;
	res NUMBER;
	BEGIN
	    N := TO_NUMBER(Y);
		IF P = 1 THEN
		    temp := mypack.OctalToDecimal(Y);
			res := mypack.DecimalToBinary(temp);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Octal','Binary',Y,res);
			commit;
		ELSIF P = 2 THEN
			res := mypack.DecimalToBinary(N);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Decimal','Binary',Y,res);
			commit;
		ELSIF P = 3 THEN
			temp := mypack.HexaToDecimal(Y);
			res := mypack.DecimalToBinary(temp);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Hexa','Binary',Y,res);
			commit;
		ELSIF P = 4 THEN
			temp := mypack.BinaryToDecimal(Y);
			res := mypack.DecimalToOctal(temp);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Binary','Octal',Y,res);
			commit;
		ELSIF P = 5 THEN
			res := mypack.DecimalToOctal(N);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Decimal','Octal',Y,res);
			commit;
		ELSIF P = 6 THEN
			temp := mypack.HexaToDecimal(Y);
			res := mypack.DecimalToOctal(temp);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Hexa','Octal',Y,res);
			commit;
		ELSIF P = 7 THEN
			res := mypack.BinaryToDecimal(Y);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Binary','Decimal',Y,res);
			commit;
		ELSIF P = 8 THEN
			res := mypack.OctalToDecimal(Y);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Octal','Decimal',Y,res);
			commit;
		ELSIF P = 9 THEN
			res := mypack.HexaToDecimal(Y);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Hexa','Decimal',Y,res);
			commit;
		ELSIF P = 10 THEN
			temp := mypack.BinaryToDecimal(Y);
			res := mypack.DecimalToHexa(temp);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Binary','Hexa',Y,res);
			commit;
		ELSIF P = 11 THEN
			temp := mypack.OctalToDecimal(Y);
			res := mypack.DecimalToHexa(temp);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Octal','Hexa',Y,res);
			commit;
		ELSIF P = 12 THEN
			res := mypack.DecimalToHexa(N);
	        DBMS_OUTPUT.PUT_LINE(res);
			INSERT INTO RECORDS1 VALUES(0,to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss'),'Conversion','Decimal','Hexa',Y,res);
			commit;
		END IF;
	END PerformOperations;

END mypack;
/

SET SERVEROUTPUT ON;
SET VERIFY OFF;
DECLARE
    test number;
	test2 number;
    X operations1.opnum%TYPE := '&choose_operation_number';  
	Y varchar(20) := '&input_number';  
	negative EXCEPTION;
BEGIN
	IF X < 0 OR X > 12 THEN
		RAISE negative;
	ELSE
	    mypack.PerformOperations(X,Y);
	END IF;
EXCEPTION
	WHEN negative THEN
		DBMS_OUTPUT.PUT_LINE('Ivalid number');
END;
/



