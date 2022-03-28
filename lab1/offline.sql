CREATE TABLE Emp (
    eid int IDENTITY,
    ename varchar(255),
    age int,
	salary int,
	PRIMARY KEY (eid),
);

CREATE TABLE Works (
    eid int FOREIGN KEY REFERENCES Emp(eid),
	did int FOREIGN KEY REFERENCES Dept(did),
	pct_time int
);

CREATE TABLE Dept (
    did int IDENTITY,
    dname varchar(255),
    budget int,
	managerid int,
	PRIMARY KEY (did),
);

INSERT INTO Emp VALUES ('A', '70', '80');
INSERT INTO Emp VALUES ('B', '20', '35');
INSERT INTO Emp VALUES ('C', '35', '60');
INSERT INTO Emp VALUES ('D', '45', '90');
INSERT INTO Emp VALUES ('E', '55', '75');
INSERT INTO Emp VALUES ('F', '25', '40');
select * from EMP;

INSERT INTO Dept VALUES ('CSE', '100', '8');
INSERT INTO Dept VALUES ('EEE', '80', '19');
INSERT INTO Dept VALUES ('ME', '20', '25');
INSERT INTO Dept VALUES ('Arc', '15', '7');
INSERT INTO Dept VALUES ('CE', '40', '5');
INSERT INTO Dept VALUES ('IPE', '10', '4');
INSERT INTO Dept VALUES ('TE', '50', '6');
INSERT INTO Dept VALUES ('BBA', '10', '5');
INSERT INTO Dept VALUES ('Arts', '80', '99');
INSERT INTO Dept VALUES ('Science', '80', '1');

select * from Dept;

INSERT INTO Works VALUES ('3', '1', '33');
INSERT INTO Works VALUES ('6', '2', '100');
INSERT INTO Works VALUES ('5', '3', '100');
INSERT INTO Works VALUES ('1', '4', '50');
INSERT INTO Works VALUES ('3', '5', '33');
INSERT INTO Works VALUES ('2', '6', '50');
INSERT INTO Works VALUES ('3', '7', '33');
INSERT INTO Works VALUES ('1', '8', '50');
INSERT INTO Works VALUES ('4', '9', '100');
INSERT INTO Works VALUES ('2', '10', '50');

select * from Works;

SELECT
e.ename,SUM(d.budget) AS Total
FROM Emp e JOIN Works w ON e.eid = w.eid JOIN Dept d ON w.did = d.did
GROUP BY e.eid,e.ename,e.salary
HAVING SUM(d.budget)<e.salary;


SELECT
  e.ename,d.managerid, 
  d.budget
FROM Dept d join Works w on d.did = w.did join Emp e on e.eid = w.eid
WHERE d.budget > 50
GROUP BY e.ename,d.managerid,d.budget
HAVING d.budget =ANY
  (SELECT d.budget
  FROM Dept d
  WHERE d.budget < 100);






