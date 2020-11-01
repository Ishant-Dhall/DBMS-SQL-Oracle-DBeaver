use n***;

create procedure showemp @id int
as
begin
select * from employees where emp_id=@id
end
exec showemp 101
drop proc showemp
/*want to update use alter command*/
/*********case****************/

select emp_id,first_name,department_id,salary,
case 
when department_id=10 then salary+500
when department_id=20 then salary+300
else salary
end as bouns
from employees;

update employees set salary=case
when department_id=10 then salary-500
when department_id=20 then salary+300
else salary 
end

select * from employees;
/**************function here*****************/
 create function showdata (@id int)
 returns varchar(25)
 as 
 begin
 declare @name varchar(25)
 select @name=first_name from employees where emp_id=@id
 return @name
 end
 /***want to update use alter command*/
 select dbo.showdata(101);

 /****************Trigger**************/
select id,name,format(changestatus,'dd-MM-yyyy hh:mm:ss')as time from oldemp2;
drop table oldemp2
 create table oldemp2 (id int,name varchar(25),changestatus datetime);
 alter trigger emptrig
 on emp2
 for update
 as 
 begin
 declare @id int
 declare @name varchar(25)
 select @id= id from deleted
 select @name=name from deleted
 insert into oldemp2 values(@id,@name,CURRENT_TIMESTAMP)
 end

 update emp2 set name='prate' where id=106;
 select * from emp2;

exec getallemp 102
