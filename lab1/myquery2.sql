clear screen;
drop TABLE money1;
CREATE TABLE money1(id number, name varchar2(20), taka number);
SELECT * from money1;

INSERT into money1 values(1,'A',100);
INSERT into money1 values(2,'B',200);
INSERT into money1 values(4,'D',300);

SELECT * from money1;

commit;


