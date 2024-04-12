--Simply grabbing the firstname, lastname, and email
select 
firstname,
lastname,
email
from Employees

--Grabbing all the employees and their salaries greater than 70,000
select 
FirstName, 
LastName, 
Salary 
from employees
where salary > 70000

-- Utilizing aliasing on the last name and finding the salaries between 60,000 and 75,000
select 
LastName as 'Last Name',
Salary
from Employees
where salary between 60000 and 75000
order by LastName asc

--Utilizing aliasing and Wildcard characters
select FirstName + ' ' +  LastName as 'Employee Name'
from Employees
where LastName LIKE '%T%'
order by FirstName asc

--Using a nested query to find the Employees who work in the London Office
select 
LastName + ', ' + FirstName as 'Employee Name'
from Employees
where OfficeID = (select OfficeID 
				from Offices 
				where OfficeName = 'London')

--Doing a simple inner join between country and region
select c.CountryName, r.RegionName
from Countries c
inner join Regions r on c.RegionID = r.RegionID
order by c.CountryName asc

-- Finding the LegalName of the client along with the country they are from by joining the two tables together
select cl.LegalName, c.CountryName
from Clients cl
inner join Countries c on cl.CountryID = c.CountryID
order by cl.LegalName

-- Selecting the different countries and regions of the offices by joining the three respective tables together
select o.OfficeName, c.CountryName, r.RegionName
from Offices o
inner join Countries c on o.CountryID = c.CountryID
inner join Regions r on c.RegionID = r.RegionID
order by o.OfficeName asc

--Joining Clients, Contracts, and ContractTypes to see the Client, contract description, and the contract type name
select cl.ClientName, c.ContractDesc, ct.ContractTypeName
from Contracts c
inner join Clients cl on c.ClientID = cl.ClientID
inner join ContractTypes ct on c.ContractTypeID = ct.ContractTypeID
order by cl.ClientName asc, ct.ContractTypeName asc

--Finding the Contract description, client name, of the clients in the United States or United Kingdom
select c.ContractDesc, cl.ClientName, co.CountryName
from Contracts c
inner join Clients cl on c.ClientID = cl.ClientID
inner join Countries co on cl.CountryID = co.CountryID
where co.CountryName IN ('United States', 'United Kingdom')
Order By co.CountryName asc, cl.ClientName asc

-- Seeing all the Employees who are currently working on a projecting
select e.FirstName + ' '+ e.LastName as 'Employee Name', 
p.ProjectName as 'Project Name'
from EmployeeProjectAssignments epa
inner join Employees e on epa.EmpID = e.EmpID
inner join Projects p on epa.ProjectID = p.ProjectID
where epa.EndDate IS NULL
order by [Employee Name] asc

-- Seeing all of the employees, their projects, their managers, the start, and end dates of their projects
select e.FirstName + ' ' + e.LastName as 'Employee Name',
p.ProjectName as 'Project Name',
mgr.FirstName + ' ' + mgr.LastName as 'Manager',
epa.StartDate as 'Start', 
epa.EndDate as 'End'
from EmployeeProjectAssignments epa
inner join Employees e on epa.EmpID = e.EmpID
inner join Projects p on epa.ProjectID = p.ProjectID
inner join Employees mgr on p.ManagerID = mgr.EmpID
order by epa.EndDate

--Finding a unique list of employees where the Client's legal name has Nippon in it.
select distinct e.FirstName + ' ' + e.LastName AS 'Employee Name'
from Employees e
inner join EmployeeProjectAssignments epa on e.EmpID = epa.EmpID
inner join Projects p on epa.ProjectID = p.ProjectID
inner join Contracts c on p.ContractID = c.ContractID
inner join Clients cl on c.ClientID = cl.ClientID
where cl.LegalName LIKE 'Nippon%'
order by e.FirstName + ' ' + e.LastName desc;

--Finding the Employees who do not have a boss
select FirstName, LastName from Employees
where SuperVisorID IS NULL

--Finding Peter Pride's supervisor using a join on a self-referencing field
select 
s.FirstName, 
s.LastName
from Employees e
inner join Employees s on e.SupervisorID = s.EmpID
where e.FirstName = 'Peter' and e.LastName = 'Pride'

-- Finding the Employee's Name and Supervisors Name together
select
e.FirstName + ' ' + e.LastName as 'Employee Name',
s.FirstName + ' ' + s.LastName as 'Supervisor Name'
from Employees e
left outer join Employees s on e.SupervisorID = s.EmpID
order by [Supervisor Name] asc

--Displaying Eric Potters total hours worked in January 2017
select SUM(wh.HoursWorked) as 'Potter Hours (Jan-17)'
from WorkHours wh
inner join Employees e on wh.EmpID = e.EmpID
where e.EmpID = (select EmpID from Employees
where FirstName = 'Eric' and LastName = 'Potter')
and wh.year = 2017
and wh.month = 1

-- Retrieving the total hours worked on each project in March 2017
select p.ProjectName as 'Project Name',
sum(wh.hoursworked) as 'Total Hours'
from WorkHours wh
inner join Projects p on wh.ProjectID = p.ProjectID
where wh.Year = 2017
and wh.Month = 3
group by p.ProjectName
order by p.ProjectName asc

-- Displaying the all the Project Names, Employee Names, and Total Hours worked within the month of May 2017
select 
p.ProjectName as 'Project Name', 
e.FirstName + ' ' + e.LastName as 'Employee Name',
sum(wh.HoursWorked) as 'Total Hours'
from WorkHours wh
inner join Employees e on wh.EmpID = e.EmpID
inner join Projects p on wh.ProjectID = p.ProjectID
where wh.Month = 5 and wh.Year = 2017
group by p.ProjectName, e.FirstName + ' ' + e.LastName
order by p.ProjectName, e.FirstName + ' ' + e.LastName

/* 
Returning a unique list of the average hours greater than 8.5 worked by an 
employee who is working on the project 'Vodafone Work Order 1 - Phase I' in May 2017
*/
select distinct
e.FirstName + ' ' + e.LastName as 'Employee Name',
avg(wh.HoursWorked) as 'Average Hours'
from WorkHours wh
inner join Employees e on wh.EmpID = e.EmpID
inner join Projects p on wh.ProjectID = p.ProjectID
where p.ProjectName = 'Vodafone Work Order 1 - Phase I'
and wh.month = 5
and wh.year = 2017
GROUP BY e.FirstName + ' ' + e.LastName
HAVING avg(wh.HoursWorked) > 8.5

-- 21
select e.FirstName + ' ' + e.LastName as 'Employee Name',
count(epa.ProjectID) as ProjectCount
from Employees e
inner join EmployeeProjectAssignments epa on e.EmpID = epa.EmpID
where EndDate IS NULL
group by e.FirstName + ' ' + e.LastName
Having count(ProjectID) > 2

--22
select LegalName
from Clients
where CountryID = 
	(select CountryID from Countries 
	where CountryName = 'United States')
order by LegalName desc

--23
select LegalName
from Clients cl
where EXISTS
(select * from Countries co
where cl.CountryID = co.CountryID
and co.CountryName = 'United States')
order by LegalName desc

--24
select CONCAT(e.FirstName, ' ', e.LastName) AS 'Employee'
from EmployeeProjectAssignments epa
right outer join Employees e on epa.EmpID = e.EmpID
where epa.StartDate IS NULL

/* Displaying the Country, Client, Project, Employee, and Supervisor 
using joins of nearly all the tables in this specific database
*/

select co.CountryName as 'Country', 
cl.ClientName as 'Client', 
p.ProjectName as 'Project', 
e.FirstName + ' ' + e.LastName as 'Employee', 
s.FirstName + ' '+ s.LastName as 'Supervisor'
from EmployeeProjectAssignments epa
inner join Projects p on epa.ProjectID = p.ProjectID
inner join Contracts c on p.ContractID = c.ContractID
inner join Clients cl on c.ClientID = cl.ClientID
inner join Countries co on cl.CountryID = co.CountryID
right outer join Employees e on epa.EmpID = e.EmpID
left outer join Employees s on p.ManagerID = s.EmpID
order by co.CountryName asc, cl.ClientName asc



