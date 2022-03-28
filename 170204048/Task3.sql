--CREATED BY: G. M. Shahariar
--SYSTEM DATE: 04-OCT-2021 04:39 AM
clear screen;
drop table APPS;
create table APPS(APP_ID number, APP_NAME VARCHAR2(12), RELEASE_DATE DATE);
insert into APPS values(100,'SKYPE','19-MAR-1990');
insert into APPS values(200,'ZOOM','21-JAN-1995');
insert into APPS values(1000,'MESSENGER','3-JUL-1989');
insert into APPS values(100,'SKYPE','19-MAR-1990');
insert into APPS values(2,'SIGNAL', '21-FEB-2015');
insert into APPS values(300,'TELEGRAM', '10-NOV-2014');
commit;
select * from APPS;

SET VERIFY OFF;
SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE APP_SEPERATE AS
	FUNCTION FIND_APPS(ID IN NUMBER)
	RETURN NUMBER;
END APP_SEPERATE;
/

CREATE OR REPLACE PACKAGE BODY APP_SEPERATE AS
FUNCTION FIND_APPS(ID IN NUMBER)
RETURN NUMBER
IS
founds int;
dates DATE;
BEGIN
	SELECT RELEASE_DATE INTO dates FROM APPS WHERE APP_ID = ID;
        found := (SYSDATE - dates) / 365;	
        IF founds>12 THEN
            DBMS_OUTPUT.PUT_LINE('longer than 12  year');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No longer than 12 year');
        END IF;
	EXCEPTION
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Many rows detected');
		WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('not found in database');
	return 0;
END FIND_APPS;
END APP_SEPERATE;
/

SET VERIFY OFF;
SET SERVEROUTPUT ON;
DECLARE
	D number;
	Dummy number;
BEGIN
	D := &X;
	Dummy := APP_SEPERATE.FIND_APPS(D);
END;
/
