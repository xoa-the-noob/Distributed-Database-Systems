--clear sreen;
drop table Emp;
drop table Dept;
drop table Works;

------------------------------a------------------------------------
CREATE TABLE Emp (
    eid int,
    ename varchar2(100),
    age int,
	salary real,  --unit of salary is thousands/K
	CONSTRAINT Emp_pk PRIMARY KEY (eid)
);
CREATE TABLE Dept (
    did int,
    dname varchar2(100),
	budget real,    --unit of budget is thousands/K
	managerid int,
	CONSTRAINT Dept_pk PRIMARY KEY (did)
);
CREATE TABLE Works (
    eid int,
	did int, 
	pct_time int
);

INSERT INTO Emp VALUES ('1','A', '50', '150');
INSERT INTO Emp VALUES ('2','B', '45', '95');
INSERT INTO Emp VALUES ('3','C', '30', '50');
INSERT INTO Emp VALUES ('4','D', '35', '50');
INSERT INTO Emp VALUES ('5','E', '32', '25');
INSERT INTO Emp VALUES ('6','A', '55', '105');
column ename format a10
select * from Emp;

INSERT INTO Dept VALUES ('1','CSE', '110', '1');
INSERT INTO Dept VALUES ('2','EEE', '20', '1');
INSERT INTO Dept VALUES ('3','IPE', '35', '2');
INSERT INTO Dept VALUES ('4','ME', '20', '2');
INSERT INTO Dept VALUES ('5','TE', '30', '3');
INSERT INTO Dept VALUES ('6','Arc', '50', '4');
INSERT INTO Dept VALUES ('7','CE', '30', '3');
INSERT INTO Dept VALUES ('8','BBA', '55', '5');
INSERT INTO Dept VALUES ('9','Arts', '51', '5');
INSERT INTO Dept VALUES ('10','Science', '80', '6');
column dname format a20
select * from Dept;

INSERT INTO Works VALUES ('1', '1', '50');
INSERT INTO Works VALUES ('1', '2', '50');
INSERT INTO Works VALUES ('4', '3', '50');
INSERT INTO Works VALUES ('4', '4', '50');
INSERT INTO Works VALUES ('5', '5', '50');
INSERT INTO Works VALUES ('6', '6', '100');
INSERT INTO Works VALUES ('5', '7', '50');
INSERT INTO Works VALUES ('3', '8', '50');
INSERT INTO Works VALUES ('3', '9', '50');
INSERT INTO Works VALUES ('2', '10', '100');
select * from Works;


---------------------------------b.1---------------------------------------
select e.ename,SUM(d.budget) as Total
from Emp e join Works w on e.eid = w.eid join Dept d on w.did = d.did
GROUP BY e.eid,e.ename,e.salary
HAVING SUM(d.budget)<e.salary;


--------------------------------b.2-----------------------------------------
select * from
( select managerid, 
  SUM(budget) AS temp
FROM Dept
GROUP BY managerid
ORDER BY SUM(budget) desc )
where rownum <= 1;

--------------------------------b.3(let 1 millions = 50k,5millions = 100k)------------------------------------------  
select e.ename,d.managerid,d.budget FROM
Dept d join Works w on d.did = w.did join Emp e on e.eid = w.eid
where d.budget>50 GROUP BY e.ename,d.managerid,d.budget
HAVING d.budget = ANY
(select d.budget from Dept d where d.budget<100);


--commit;