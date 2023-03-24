use TASKTO

--1. Create User-define Scalar function to calculate percentage of all students after creating the following table.
--TABLE CREATION
create table studtbl (studentid int identity(1,1), studentname varchar(20), semester varchar(20), securedmarks int, totalmarks int);
--TABLE INSERTION
insert into studtbl values ('harshan','sem 1',490,500),('hemanth','sem 3',450,500),('hari','sem 1',430,500),('harita','sem 3',470,500),('dharshan','sem 1',420,500)
--SELECT QUERY
select * from studtbl;
--drop table
drop table studtbl;
--SCALAR FUNCTION
create function calpercent(@mark int,@tmark int)
Returns int
as 
begin
declare @per int
set @per = ((@mark * 100)/ @tmark)
return @per
end
--function call 
select dbo.calpercent(securedmarks,totalmarks) as percentage from studtbl;
--function drop
drop function calpercent

--2. Create user-defined function to generate a table that contains result of Sem 3 students.
create function ressem3(@sem varchar(20))
Returns table
as 
return (select * from dbo.studtbl where semester = @sem)
--function call 
select * from ressem3('sem 3');
--function drop
drop function ressem3

--3. Write SQL stored procedure to retrieve all students details. (No parameters)
create procedure sp_stud_details 
AS
BEGIN
select * from studtbl
end
--executing the procedure
exec sp_stud_details;

--4. Write SQL store procedure to display Sem 1 students details. (One parameter)
create procedure sp_stud_details1(@semres varchar(20)) 
AS
BEGIN
select * from studtbl where semester=@semres
end
--executing the procedure
exec sp_stud_details1 'sem 1';

--5. Write SQL Stored Procedure to retrieve total number of students details. (OUTPUT Parameter)
create procedure sp_stud_details3(@semres varchar(20) output) 
AS
BEGIN
select COUNT(STUDENTID)AS TOTAL_NO_OF_STUDENTS FROM STUDTBL
end
--executing the procedure
DECLARE @TOTAL INT

EXEC sp_stud_details3 @TOTAL OUTPUT;

PRINT @TOTAL
--DROP PROCEDURE
drop procedure sp_stud_details3

--6. Show the working of Merge Statement by creating a backup for the students details of only students in Sem 1.
--TARGET TABLE
select * into dummy_studtbl FROM STUDTBL;
--select query
select * from dummy_studtbl--target table
select * from studtbl;--soruce table
--table insertion in source table
insert into studtbl values('ram','sem 1',430,500)
--table insertion in target table
insert into dummy_studtbl values('ravi','sem 1',430,500)
--MERGE STATEMENT
MERGE DUMMY_STUDTBL T USING (select * from studtbl where semester = 'sem 1')as s
ON (s.studentid = t.studentid)
when matched 
then update set t.studentname = s.studentname
when not matched by target
then insert (studentname, semester, securedmarks, totalmarks)
values(s.studentname,s.semester,s.securedmarks,s.totalmarks)
when not matched by source
then delete;