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
create function ressem3(@sem varchar,@sem_mark int)
Returns varchar
as 
begin
declare @sem3res
set @sem3res = @sem =   
return @sem3res
end
--function call 
select dbo.ressem3(semester,securedmarks) as percentage from studtbl;
--function drop
drop function ressem3
