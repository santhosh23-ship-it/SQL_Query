Create database assignment
use assignment
/* Question:1 

tables creation

*/



	create table departments(
	departmentid int primary key,
	departmentname varchar(50) not null unique)
  

	create table students( 
	studentid int primary key,
	name varchar(50) not null ,
	age int check (age >=17),
	departmentid int foreign key  references departments(departmentid))

	create table courses(
	courseid int primary key,
	coursename varchar(60) not null,
	departmentid int foreign key references departments(departmentid))


/* Question:2
 inserting
 */
	select * from departments

	insert into departments 
	values
	(1, 'CSE'),
	(2, 'MBA'),
	(3, 'ECE'),
	(4, 'EEE'),
	(5, 'MECH')


	select * from students

	insert into students
	values
	(1,'Santosh',22,1),
	(2,'Kasi',18,1),
	(3,'Surya',21,2),
	(4,'Kiran',19,5),
	(5,'Mani',20,1),
	(6,'Charishma',23,2),
	(7,'Teja',18,3),
	(8,'Gani',26,4),
	(9,'Byresh',25,3),
	(10,'Ravi',26,2)



	select * from courses


	insert into courses 
	values 
	(1,'SQL',1),
	(2,'Fullstock',5),
	(3,'Fullstock',2),
	(4,'SQL',3),
	(5,'BACKEND',4),
	(6,'Fullstock',1),
	(7,'PYTHON',1),
	(8,'Data Science',2),
	(9,'SQL',3),
	(10,'Fullstock',4),
	(11,'Powerbi',5),
	(12,'Python',1),
	(13,'SQL',2),
	(14,'Data Science',3),
	(15,'Fullstock',4)
/*
Question:3
where and operators
display all students whose age is greater than 20
*/


	select age from students where age>20

	--  or  --
	select * from students where age>20


	--display all courses of the "computer science' department.


	SELECT * 
	FROM Courses, Departments
	WHERE Courses.DepartmentID = Departments.DepartmentID
	AND Departments.DepartmentName = 'CSE'

	-- display students whose age is between 18 and 22

	select * from students where age between 18 and 22

 
/*
Question:4
joins (left ,inner ,right)
inner join 
students with departments to show students names with their department names.
*/

	select s.studentid, s.name, d.departmentname
	from students s
	inner join departments d
	on s.departmentid = d.departmentid;


	-- left join
	--courses eith departments to show all courses, even if some departments does not exist.

	select c.*, c.coursename, d.departmentname from courses c
	left join departments d
	on c.courseid= d.departmentid
	
	select c.coursename, d.departmentname
	from courses c
	left join departments d
	on c.departmentid = d.departmentid;
	

	-- right join 
	-- students with courses to show all courses ,even if no students has enrolled in them.

	select s.studentid, s.name, c.coursename from students s
	right join courses c
	on c.courseid=s.studentid
