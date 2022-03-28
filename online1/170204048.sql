clear screen;
drop table money;
drop table deposit;

create table money(id number, name varchar2(20), taka number);
create table deposit(id number, name varchar2(20), taka number);

insert into money values(1,'Alam',100);
insert into money values(2,'Baki',110);
insert into money values(3,'Ceri',120);
insert into money values(4,'Dipto',130);

insert into deposit values(1,'Elias',140);
insert into deposit values(2,'Farabi',150);
insert into deposit values(3,'Gias',160);
insert into deposit values(4,'Hanif',170);

commit;

select * from money;
select * from deposit;

SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
    x varchar2(20):= '&enter_name';
	did int;
	checkn varchar2(20);
	--dname money.name%TYPE;
	dtaka int;
	num int;
	j int;
	k int;
    

BEGIN
     select count(id) into j from money;
     select count(id) into k from deposit;
     FOR i in 1..j LOOP
		select name into checkn from money where id = i ;
		IF checkn = x THEN
			select id into did from money where id = i ;
			select taka into dtaka from money where id = i ;
			DBMS_OUTPUT.PUT_LINE('Money table ');
			DBMS_OUTPUT.PUT_LINE(did);
			DBMS_OUTPUT.PUT_LINE(x);
			DBMS_OUTPUT.PUT_LINE(dtaka);
		END IF;
		
END LOOP;

FOR i in 1..k LOOP
		select name into checkn from deposit where id = i ;
		IF checkn = x THEN
			select id into did from deposit where id = i ;
			select taka into dtaka from deposit where id = i ;
			DBMS_OUTPUT.PUT_LINE('Deposit table');
			DBMS_OUTPUT.PUT_LINE(did);
			DBMS_OUTPUT.PUT_LINE(x);
			DBMS_OUTPUT.PUT_LINE(dtaka);
		END IF;
END LOOP;
	
	     
END;
/