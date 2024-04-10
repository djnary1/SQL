--1
select 
firstname,
lastname,
email
from Employees

--2
select 
FirstName, 
LastName, 
Salary 
from employees
where salary > 70000

--3
select 
LastName as 'Last Name',
Salary
from Employees
where salary between 60000 and 75000
order by LastName asc

--4
select FirstName + ' ' +  LastName as 'Employee Name'
from Employees
where LastName LIKE '%T%'
order by FirstName asc

--5
select 
LastName + ', ' + FirstName as 'Employee Name'
from Employees
where OfficeID = (select OfficeID 
				from Offices 
				where OfficeName = 'London')

--6
select * from Regions
select * from Countries

select c.CountryName, r.RegionName
from Countries c
inner join Regions r on c.RegionID = r.RegionID
order by c.CountryName asc

--7
select * from Clients

select cl.LegalName, c.CountryName
from Clients cl
inner join Countries c on cl.CountryID = c.CountryID
order by cl.LegalName

--8
select o.OfficeName, c.CountryName, r.RegionName
from Offices o
inner join Countries c on o.CountryID = c.CountryID
inner join Regions r on c.RegionID = r.RegionID
order by o.OfficeName asc

--9
select * from Clients
select * from ContractTypes
select * from Contracts

select cl.ClientName, c.ContractDesc, ct.ContractTypeName
from Contracts c
inner join Clients cl on c.ClientID = cl.ClientID
inner join ContractTypes ct on c.ContractTypeID = ct.ContractTypeID
order by cl.ClientName asc, ct.ContractTypeName asc

--10
select c.ContractDesc, cl.ClientName, co.CountryName
from Contracts c
inner join Clients cl on c.ClientID = cl.ClientID
inner join Countries co on cl.CountryID = co.CountryID
where co.CountryName IN ('United States', 'United Kingdom')
Order By co.CountryName asc, cl.ClientName asc

--11
select e.FirstName + ' '+ e.LastName as 'Employee Name', 
p.ProjectName as 'Project Name'
from EmployeeProjectAssignments epa
inner join Employees e on epa.EmpID = e.EmpID
inner join Projects p on epa.ProjectID = p.ProjectID
where epa.EndDate IS NULL
order by [Employee Name] asc

--12
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

--13
select distinct e.FirstName + ' ' + e.LastName AS 'Employee Name'
from Employees e
inner join EmployeeProjectAssignments epa on e.EmpID = epa.EmpID
inner join Projects p on epa.ProjectID = p.ProjectID
inner join Contracts c on p.ContractID = c.ContractID
inner join Clients cl on c.ClientID = cl.ClientID
where cl.LegalName LIKE 'Nippon%'
order by e.FirstName + ' ' + e.LastName desc;


select * from EmployeeProjectAssignments
select * from Employees
select * from Clients
select * from Projects
select * from Contracts

--14
select FirstName, LastName from Employees
where SuperVisorID IS NULL
select * from Employees

--15
select 
s.FirstName, 
s.LastName
from Employees e
inner join Employees s on e.SupervisorID = s.EmpID
where e.FirstName = 'Peter' and e.LastName = 'Pride'

--16
select
e.FirstName + ' ' + e.LastName as 'Employee Name',
s.FirstName + ' ' + s.LastName as 'Supervisor Name'
from Employees e
left outer join Employees s on e.SupervisorID = s.EmpID
order by [Supervisor Name] asc
select * from WorkHours
--17
select SUM(wh.HoursWorked) as 'Potter Hours (Jan-17)'
from WorkHours wh
inner join Employees e on wh.EmpID = e.EmpID
where e.EmpID = (select EmpID from Employees
where FirstName = 'Eric' and LastName = 'Potter')
and wh.year = 2017
and wh.month = 1

--18
select p.ProjectName as 'Project Name',
sum(wh.hoursworked) as 'Total Hours'
from WorkHours wh
inner join Projects p on wh.ProjectID = p.ProjectID
where wh.Year = 2017
and wh.Month = 3
group by p.ProjectName
order by p.ProjectName asc

--19
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

--20
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

--21
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

--25 Bonus

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




