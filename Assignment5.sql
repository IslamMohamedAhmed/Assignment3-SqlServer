
--Assignment 5
/*
Part 1 Using iti db
1.	Retrieve a number of students who have a value in their age. 
*/

select COUNT(St_Age)
from Student


/*
Part 1 Using iti db
2.	Display number of courses for each topic name 
*/
select t.Top_Name, COUNT(c.Crs_Id) as [Courses No.]
from Course c inner join Topic t
on c.Top_Id  = t.Top_Id
group by t.Top_Name


/*
Part 1 Using iti db
3.	Select Student first name and the data of his supervisor  
*/
select stud.St_Fname,super.*
from student stud inner join student super
on stud.St_super = super.St_Id


/*
Part 1 Using iti db
4.	Display student with the following Format (use isNull function)
*/
select stud.St_Id as [Student ID], ISNULL(stud.St_Fname,' ')+' '+ISNULL(stud.St_Lname,' ') as [Student Full Name], dep.Dept_Name as [Department Name]
from student stud inner join department dep
on stud.Dept_Id = dep.Dept_Id

/*
Part 1 Using iti db
5.	Select instructor name and his salary but if there is no salary display value ‘0000’ . “use one of Null Function” 
*/
select Ins_Name,ISNULL(Salary,0000) as [Salary]
from instructor


/*
Part 1 Using iti db
6.	Select Supervisor first name and the count of students who supervises on them 
*/
select super.St_Fname,COUNT(stud.St_Id) [Students No.]
from student stud inner join student super
on stud.st_super = super.st_id
group by super.St_Fname


/*
Part 1 Using iti db
7.	Display max and min salary for instructors 
*/
select MAX(Salary) as [Max S.],MIN(Salary) as [Min S.]
from instructor


/*
Part 1 Using iti db
8.	Select Average Salary for instructors 
*/
select AVG(Salary) as [Instructors Salary Average]
from instructor


/*
Part 1 Using iti db
9.	Display instructors who have salaries less than the average salary of all instructors. 
*/
select *
from instructor
where Salary < (select AVG(Salary) from Instructor)


/*
Part 1 Using iti db
10.	Display the Department name that contains the instructor who receives the minimum salary
*/

select d.Dept_Name
from instructor i inner join Department d
on i.Dept_Id = d.Dept_Id
where i.Salary = (select min(Salary) from Instructor)


/*
Part 2 Using my company db
DDL
1.	For each project, list the project name and the total hours per week (for all employees) spent on that project.
*/

select p.Pname,sum(wf.Hours) as [Project Working Hours]
from project p inner join works_for wf
on p.pnumber = wf.pno inner join employee e
on e.ssn = wf.essn
group by p.pname


/*
Part 2 Using my company db

2.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
*/
select d.dname, max(e.Salary) as [MX Salary],min(e.Salary) as [MN Salary],avg(e.Salary) as [AVG Salary]
from employee e inner join departments d
on e.dno = d.dnum
group by d.dname

/*
Part 2 Using my company db

3.	Retrieve a list of employees and the projects they are working on ordered by department and within each department ordered alphabetically by last name, first name.
*/
select  d.Dname, e.Fname,p.Pname 
from employee e inner join departments d
on e.dno = d.dnum inner join works_for wf
on e.ssn = wf.essn inner join project p
on p.pnumber = wf.pno
order by d.Dname asc


/*

Part 2 Using my company db

4.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% 
*/


update e set Salary = Salary*1.3
from project p inner join works_for wf
on p.pnumber = wf.pno inner join employee e
on e.ssn = wf.essn
where p.pname = 'Al Rabwah'





/*

Part 3 Using my company db
1.	Retrieve the names of all employees in department 10 who work more than or equal 10 hours per week on the "AL Rabwah" project.
*/

select e.Fname+' '+e.Lname as [Full Name]
from  Employee e inner join Works_for wf
on e.SSN = wf.ESSn inner join Project p
on p.Pnumber = wf.Pno where p.Pname = 'AL Rabwah' and e.Dno = 10


/*

Part 3 Using my company db
2.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name
*/
select e.Fname+' '+e.Lname as [Full Name],p.Pname
from  Employee e inner join Works_for wf
on e.SSN = wf.ESSn inner join Project p
on p.Pnumber = wf.Pno
order by p.Pname asc

/*

Part 3 Using my company db
3.	For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate
*/

select p.Pname,d.Dname,e.Lname,e.Address,e.Bdate
from Project p inner join Departments d 
on p.Dnum = d.Dnum inner join Employee e
on d.MGRSSN = e.SSN where p.City = 'Cairo'


/*

Part 3 Using my company db
4.	Display the data of the department which has the smallest employee ID over all employees' ID.
*/
select d.*
from employee e inner join departments d
on d.dnum = e.Dno
where e.ssn = (select min(ssn) from Employee)



/*

Part 3 Using my company db
5.	List the last name of all managers who have no dependents
*/
select distinct e.Lname
from departments d inner join employee e
on e.ssn = d.mgrssn inner join dependent de
on de.essn != e.ssn


/*

Part 3 Using my company db
6.	For each department-- if its average salary is less than the average salary of all employees display its number, name and number of its employees.
*/
select d.Dname, COUNT(e.SSN) as [department employees]
from employee e inner join departments d
on e.dno = d.dnum
group by d.Dname
having avg(e.Salary) < (select AVG(salary) from employee)

/*

Part 3 Using my company db
7.	Try to get the max 2 salaries using subquery
*/

select
  (SELECT MAX(Salary) FROM Employee) [salary 1],
  (SELECT MAX(Salary) FROM Employee
  WHERE Salary NOT IN (SELECT MAX(Salary) FROM Employee )) as [salary 2]























