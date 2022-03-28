set lines 256
set trimout on
set tab off

select * from records1@site_link;

set serveroutput on format wrapped;
begin
    DBMS_OUTPUT.put_line('Filter based on Input Type');
end;
/
select * from records1@site_link where reciptype='&Input_Type';

set serveroutput on format wrapped;
begin
    DBMS_OUTPUT.put_line('Filter based on Output Type');
end;
/
select * from records1@site_link where recoptype='&Output_Type';

set serveroutput on format wrapped;
begin
    DBMS_OUTPUT.put_line('Filter based on Input and Output Type');
end;
/

set serveroutput on format wrapped;
begin
    DBMS_OUTPUT.put_line('Filter based on Input Value');
end;
/
select * from records1@site_link where recipvalue=&recipvalue;


set serveroutput on format wrapped;
begin
    DBMS_OUTPUT.put_line('Filter based on Output Value');
end;
/
select * from records1@site_link where recopvalue=&recopvalue;


set serveroutput on format wrapped;
begin
    DBMS_OUTPUT.put_line('Filter based on Input and Output Value');
end;
/
select * from records1@site_link where reciptype='&Input_Type' AND recoptype='&Output_Type';
select * from records1@site_link where recipvalue=&recipvalue AND recopvalue=&recopvalue;

set serveroutput on format wrapped;
begin
DBMS_OUTPUT.put_line('Entries of yesterday');
end;
/
select * from records1@site_link where recdate = to_date(sysdate-1, 'dd/mm/yyyy hh24:mi:ss');


set serveroutput on format wrapped;
begin
DBMS_OUTPUT.put_line('Entries of today');
end;
/
select * from records1@site_link where recdate = to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss');
select count(recnum) as TotalRecordsToday from records1@site_link where recdate = to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss');


set serveroutput on format wrapped;
begin
DBMS_OUTPUT.put_line('Show types');
end;
/
select reciptype,recoptype,COUNT(recnum) as Total from records1@site_link GROUP BY reciptype,recoptype;


set serveroutput on format wrapped;
begin
DBMS_OUTPUT.put_line('Show types and date');
end;
/
select reciptype,recoptype,recdate,COUNT(recnum) as Total 
from records1@site_link
GROUP BY reciptype,recoptype,recdate 
HAVING recdate = to_date(sysdate, 'dd/mm/yyyy hh24:mi:ss');