create database n•••;
use n•••;

create table employees (emp_id int,first_name varchar(25),
last_name varchar(25),salary int,department_id int);

create table departments(emp_id int,department_name varchar(25));

drop table departments;
insert into employees values(106,'kaur','pop',10000,30);
select * from employees;
select * from departments;
insert into departments values(106,'main');

select employees.emp_id,employees.first_name,employees.salary,employees.department_id,
departments.department_name
from employees right join departments on employees.emp_id=departments.emp_id;

select employees.emp_id,employees.first_name,employees.salary,departments.department_name
from employees full outer join departments on employees.emp_id=departments.emp_id;

select department_id from employees;

execute sp_help employees;

select count(*),department_id from employees group by department_id;

select count(*),department_id from employees group by department_id having count(department_id)>2;


select first_name,salary,department_id from employees where department_id>all(select department_id from employees where department_id>10);
															
select first_name,salary from employees where first_name like 'san%';

select getempbyid(105);


create table emp(id int,name varchar(25));

insert into emp values(102,'ni');

alter table emp add fee int;

execute sp_help emp; 

truncate table emp;

select * into cpyemp from employees;

select * from employees;

/********************deleteDuplicaterows******************************/

with empdel as
(
	select *,ROW_NUMBER() over(partition by id order by id) as rownumber
	from emp
)
delete from empdel where rownumber>1;

select * from employees;

select * into copyemp from employees;

select * from copyemp;

create table emp3(id int primary key identity(100,1),name varchar(30));

execute sp_help emp3;
insert into emp3(id,name)select emp_id,first_name from employees where department_id=10;

select * from emp3;
drop table emp3;
insert into emp3(name) values('vimal');


create table student(s_id int primary key,s_name varchar(30),fee int);

create table course(c_id varchar(25),c_name varchar(25),
s_id int foreign key references student(s_id));

insert into student values(102,'vimal',2500);


 select * from student;

 insert into course values('c102','cpp',102);

 select * from course;

 select student.s_id,student.s_name,student.fee,course.c_name
 from student inner join course on student.s_id=course.s_id;


 create table voter(voter_name varchar(25),age int check(age>=18));

 insert into voter values('sandeep',19);
 select * from voter;

 create table location(location_id int,city varchar(25) default('Delhi'));


 insert into location(location_id,city) values(102,'Hr');

 select * from location;

 create view empview as select emp_id,first_name from employees where department_id=10;

 select * from empview;
 
 create index empidx on employees(emp_id);

 select * from employees where emp_id=101;




 
