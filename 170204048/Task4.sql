
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

SET SERVEROUTPUT ON;
SET VERIFY OFF;
CREATE OR REPLACE TRIGGER FIX_NAME
BEFORE INSERT
ON APPS
FOR EACH ROW
BEGIN
	:NEW.APP_NAME := UPPER(:NEW.APP_NAME);
END;
/
ACCEPT n CHAR PROMPT 'Input: '
DECLARE
	name APPS.APP_NAME%TYPE;
BEGIN
	name := &n;
	INSERT INTO APPS VALUES(400, name,'10-DEC-2014');
END;
/