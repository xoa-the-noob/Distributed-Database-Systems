drop TABLE records1;
CREATE TABLE records1(
        recnum NUMBER,
		recdate date,
		rectype varchar2(20), 
		reciptype varchar2(20), 
		recoptype varchar2(20), 
		recipvalue varchar2(20), 
		recopvalue NUMBER
		);
SELECT * from records1;

CREATE SEQUENCE SEQ1;
START WITH 1;

commit;