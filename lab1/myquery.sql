clear screen;
drop TABLE money;
CREATE TABLE money(id number, name varchar2(20), taka number);
SELECT * from money;

INSERT into money values(1,'A',100);
INSERT into money values(2,'B',200);
INSERT into money values(3,'C',300);

SELECT * from money;

commit;

