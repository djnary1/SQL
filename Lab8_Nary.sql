create database hourglass
go

use hourglass
go

CREATE TABLE Regions
(RegionID int not null,
 RegionName varchar(40),
 CONSTRAINT PK_Regions PRIMARY KEY (RegionID));

go

CREATE TABLE Countries
(CountryID int not null,
 CountryName varchar(50),
 RegionID int not null,
 CONSTRAINT PK_Countries PRIMARY KEY (CountryID),
 CONSTRAINT FK_CountriesRegions FOREIGN KEY (RegionID) References Regions);

go

CREATE TABLE Offices
(OfficeID int,
OfficeName varchar(50),
CountryID int not null,
CONSTRAINT pk_Offices PRIMARY KEY (OfficeID),
CONSTRAINT fk_Offices_Countries FOREIGN KEY (CountryID) REFERENCES Countries)

go

CREATE TABLE Employees
(EmpID int,
FirstName varchar(30),
LastName varchar(50),
Email varchar(50),
Salary decimal(10, 2),
OfficeID int not null,
SupervisorID int,
CONSTRAINT pk_Employees PRIMARY KEY (EmpID),
CONSTRAINT fk_Employees_Offices FOREIGN KEY (OfficeID) REFERENCES Offices,
CONSTRAINT fk_Employees_Employees FOREIGN KEY (SupervisorID) REFERENCES Employees)

go

CREATE TABLE Clients
(ClientID int,
LegalName varchar(100),
ClientName varchar(50),
CountryID int not null,
CONSTRAINT pk_Clients PRIMARY KEY (ClientID),
CONSTRAINT fk_Clients_Countries FOREIGN KEY (CountryID) REFERENCES Countries)

go

CREATE TABLE ContractTypes
(ContractTypeID int not null,
 ContractTypeName varchar(50),
 CONSTRAINT pk_ContractTypes PRIMARY KEY (ContractTypeID))

go

CREATE TABLE Contracts
(ContractID int not null,
 ContractDesc varchar(100),
 ClientID int not null,
 ContractTypeID int not null,
 CONSTRAINT PK_Contracts PRIMARY KEY (ContractID),
 CONSTRAINT FK_ContractsClients FOREIGN KEY (ClientID) REFERENCES Clients,
 CONSTRAINT FK_ContractsContractTypes FOREIGN KEY (ContractTypeID) REFERENCES ContractTypes)

go

CREATE TABLE Projects
(ProjectID int,
ProjectName varchar(100),
ManagerID int not null,
ContractID int not null,
CONSTRAINT pk_Projects PRIMARY KEY (ProjectID),
CONSTRAINT fk_Projects_Employees FOREIGN KEY (ManagerID) REFERENCES Employees,
CONSTRAINT fk_Projects_Contracts FOREIGN KEY (ContractID) REFERENCES Contracts)

go

CREATE TABLE EmployeeProjectAssignments
(ProjectID int,
EmpID int,
StartDate smalldatetime,
EndDate smalldatetime,
CONSTRAINT pk_EmployeeProjectAssignments PRIMARY KEY (ProjectID, EmpID),
CONSTRAINT fk_EmployeeProjectAssignments_Projects FOREIGN KEY (ProjectID) REFERENCES Projects,
CONSTRAINT fk_EmployeeProjectAssignments_Employees FOREIGN KEY (EmpID) REFERENCES Employees)

go

CREATE TABLE WorkHours
(ProjectID int,
EmpID int,
Day int,
Month int,
Year int,
HoursWorked float,
CONSTRAINT pk_WorkHours PRIMARY KEY (ProjectID, EmpID, Day, Month, Year),
CONSTRAINT fk_WorkHours_Projects FOREIGN KEY (ProjectID) REFERENCES Projects,
CONSTRAINT fk_WorkHours_Employees FOREIGN KEY (EmpID) REFERENCES Employees)

go

insert regions select 1, 'North America'
insert regions select 2, 'Central and Latin America'
insert regions select 3, 'Asia and Pacific'
insert regions select 4, 'Europe, Middle East, and Africa'

go

insert countries select 1, 'United States', 1
insert countries select 2, 'Canada', 1
insert countries select 3, 'United Kingdom', 4
insert countries select 4, 'France', 4
insert countries select 5, 'Spain', 4
insert countries select 6, 'Italy', 4
insert countries select 7, 'Thailand', 3
insert countries select 8, 'Singapore', 3
insert countries select 9, 'Panama', 2
insert countries select 10, 'Japan', 3
insert countries select 11, 'Germany', 4
insert countries select 12, 'China', 3

go

insert offices select 1, 'Cambridge', 1
insert offices select 2, 'Denver', 1
insert offices select 3, 'London', 3
insert offices select 4, 'Singapore', 8
insert offices select 5, 'Paris', 4
insert offices select 6, 'Rome', 6
insert offices select 7, 'Madrid', 5

go

insert employees select 1, 'Matthew', 'Smith', 'msmith@cms.com', 45000, 1, null
insert employees select 2, 'Mark', 'Jones', 'mjones@cms.com ', 94000, 1, 1
insert employees select 3, 'Luke', 'Rice', 'lrice@cms.com', 65000, 4, 1
insert employees select 4, 'John', 'Rich', 'jrich@cms.com', 74000, 5, 1
insert employees select 5, 'James', 'Bolt', 'jbolt@cms.com', 40000, 6, 2
insert employees select 6, 'Peter', 'Pride', 'ppride@cms.com', 60000, 3, 3
insert employees select 7, 'Eric', 'Potter', 'epotter@cms.com', 81000, 2, 3
insert employees select 8, 'Paul', 'Davis', 'pdavis@cms.com', 103000, 1, 7
insert employees select 9, 'David', 'Baxter', 'dbaxter@cms.com', 75000, 7, 4
insert employees select 10, 'Andrew', 'Lemmons', 'alemmons@cms.com', 53000, 3, 4

go

insert clients select 1, 'Comcast Business Telecom, Inc.', 'Comcast', 1
insert clients select 2, 'Verizon Communications, Inc.', 'Verizon', 1
insert clients select 3, 'Vodafone Group, plc', 'Vodafone', 3
insert clients select 4, 'Nippon Telegraph & Telephone Corporation', 'Nippon', 10
insert clients select 5, 'Deutsche Telekom AG', 'DT', 11
insert clients select 6, 'China Mobile, Ltd.', 'China Mobile', 12
insert clients select 7, 'Telefonica S.A.', 'Telefonica', 5

go

insert contracttypes select 1, 'Maintenance'
insert contracttypes select 2, 'Fixed Price'
insert contracttypes select 3, 'License'
insert contracttypes select 4, 'Time and Materials'

go

insert contracts select 1, 'Initial License BP Product', 1, 3
insert contracts select 2, 'Initial License OM Product', 2, 3
insert contracts select 3, 'Work Order 1', 3, 2
insert contracts select 4, 'Work Order - 24x7 support', 1, 1
insert contracts select 5, 'Work Order 1', 4, 4
insert contracts select 6, 'Work Order 2', 4, 4
insert contracts select 7, 'Work Order 2', 3, 2
insert contracts select 8, 'Work Order 3', 3, 4
insert contracts select 9, 'Work Order - SLA 2', 2, 1
insert contracts select 10, 'Initial License BP Product', 5, 3
insert contracts select 11, 'Work Order - SLA 1', 5, 1
insert contracts select 12, 'Work Order - Upgrade version', 5, 2
insert contracts select 13, 'Work Order - Customization', 5, 4
insert contracts select 14, 'Initial License BP + OM', 6, 3
insert contracts select 15, 'Work Order 1', 7, 2
insert contracts select 16, 'Work Order - 24x7 support', 6, 1
insert contracts select 17, 'Work Order 2', 7, 2


go

insert projects select 1, 'Comcast Initial License BP Product', 2, 1
insert projects select 2, 'Verizon Initial License OM Product', 3, 2
insert projects select 3, 'Vodafone Work Order 1 - Phase I', 4, 3
insert projects select 4, 'Vodafone Work Order 1 - Phase II', 4, 3
insert projects select 5, 'Comcast Work Order - 24x7 support', 2, 4
insert projects select 6, 'Nippon Work Order 1 - Site 1', 4, 5
insert projects select 7, 'Nippon Work Order 1 - Site 2', 4, 5
insert projects select 8, 'Nippon Work Order 1 - Site 3', 4, 5
insert projects select 9, 'Nippon Work Order 2 - Customization', 8, 6
insert projects select 10, 'Vodafone Work Order 2', 8, 7
insert projects select 11, 'Vodafone Work Order 3', 6, 8
insert projects select 12, 'Verizon Work Order - SLA 2', 4, 9
insert projects select 13, 'DT Initial License BP Product (50,000 subscribers - Site A)', 3, 10
insert projects select 14, 'DT Initial License BP Product (20,000 subscribers - Site B)', 2, 10
insert projects select 15, 'DT Work Order - SLA 1', 6, 11
insert projects select 16, 'DT Work Order - Upgrade version (Site A)', 3, 12
insert projects select 17, 'DT Work Order - Upgrade version (Site B)', 8, 12
insert projects select 18, 'DT Work Order - Customization', 2, 13
insert projects select 19, 'China Mobile Initial License BP + OM', 10, 14
insert projects select 20, 'Telefonica Work Order 1', 4, 15
insert projects select 21, 'China Mobile Work Order - 24x7 support', 3, 16
insert projects select 22, 'Telefonica Work Order 2 - Phase I', 10, 17
insert projects select 23, 'Telefonica Work Order 2 - Phase II', 10, 17
insert projects select 24, 'Telefonica Work Order 2 - Phase III', 10, 17

go

insert employeeprojectassignments select 3, 3, '12/20/2016', '5/15/2017'
insert employeeprojectassignments select 3, 6, '12/20/2016', '5/15/2017'
insert employeeprojectassignments select 3, 7, '12/20/2016', '5/15/2017'
insert employeeprojectassignments select 4, 4, '6/23/2017', '7/1/2017'
insert employeeprojectassignments select 4, 2, '5/16/2017', null
insert employeeprojectassignments select 5, 7, '10/18/2016', null
insert employeeprojectassignments select 5, 8, '10/18/2016', null
insert employeeprojectassignments select 5, 4, '7/2/2017', null
insert employeeprojectassignments select 6, 9, '2/3/2017', '2/28/2017'
insert employeeprojectassignments select 7, 5, '2/15/2017', '3/20/2017'
insert employeeprojectassignments select 8, 3, '3/1/2017', '4/1/2017'
insert employeeprojectassignments select 9, 9, '5/15/2017', null
insert employeeprojectassignments select 10, 10, '7/5/2017', '7/15/2017'
insert employeeprojectassignments select 11, 9, '7/20/2017', null
insert employeeprojectassignments select 12, 2, '3/1/2016', null
insert employeeprojectassignments select 15, 6, '12/30/2015', null
insert employeeprojectassignments select 16, 2, '1/1/2017', '3/15/2017'
insert employeeprojectassignments select 17, 6, '1/1/2017', '4/1/2017'
insert employeeprojectassignments select 18, 2, '5/1/2017', null
insert employeeprojectassignments select 18, 6, '5/1/2017', null
insert employeeprojectassignments select 20, 4, '2/20/2017', '7/31/2017'
insert employeeprojectassignments select 20, 5, '2/20/2017', '7/31/2017'
insert employeeprojectassignments select 20, 10, '2/20/2017', '7/31/2017'
insert employeeprojectassignments select 21, 3, '8/15/2016', null
insert employeeprojectassignments select 22, 4, '8/1/2017', '8/31/2017'
insert employeeprojectassignments select 23, 5, '9/1/2017', '9/30/2017'
insert employeeprojectassignments select 24, 10, '10/1/2017', null

go

insert workhours select 3, 3, 20, 12, 2016, 8
insert workhours select 3, 3, 21, 12, 2016, 8
insert workhours select 3, 3, 22, 12, 2016, 8
insert workhours select 3, 3, 23, 12, 2016, 8
insert workhours select 3, 3, 26, 12, 2016, 8
insert workhours select 3, 3, 27, 12, 2016, 7
insert workhours select 3, 3, 28, 12, 2016, 10
insert workhours select 3, 3, 29, 12, 2016, 10
insert workhours select 3, 3, 30, 12, 2016, 10
insert workhours select 3, 3, 2, 1, 2017, 9
insert workhours select 3, 3, 3, 1, 2017, 8
insert workhours select 3, 3, 4, 1, 2017, 8
insert workhours select 3, 3, 5, 1, 2017, 8
insert workhours select 3, 3, 6, 1, 2017, 8
insert workhours select 3, 3, 9, 1, 2017, 8
insert workhours select 3, 3, 10, 1, 2017, 8
insert workhours select 3, 3, 11, 1, 2017, 8
insert workhours select 3, 3, 12, 1, 2017, 8
insert workhours select 3, 3, 13, 1, 2017, 8
insert workhours select 3, 3, 16, 1, 2017, 8
insert workhours select 3, 3, 17, 1, 2017, 9
insert workhours select 3, 3, 18, 1, 2017, 9
insert workhours select 3, 3, 19, 1, 2017, 9
insert workhours select 3, 3, 20, 1, 2017, 9
insert workhours select 3, 3, 23, 1, 2017, 10
insert workhours select 3, 3, 24, 1, 2017, 10
insert workhours select 3, 3, 25, 1, 2017, 10
insert workhours select 3, 3, 26, 1, 2017, 10
insert workhours select 3, 3, 27, 1, 2017, 11
insert workhours select 3, 3, 30, 1, 2017, 8
insert workhours select 3, 3, 31, 1, 2017, 8
insert workhours select 3, 3, 1, 2, 2017, 8
insert workhours select 3, 3, 2, 2, 2017, 8
insert workhours select 3, 3, 3, 2, 2017, 7
insert workhours select 3, 3, 6, 2, 2017, 5
insert workhours select 3, 3, 7, 2, 2017, 10
insert workhours select 3, 3, 8, 2, 2017, 10
insert workhours select 3, 3, 9, 2, 2017, 10
insert workhours select 3, 3, 10, 2, 2017, 8
insert workhours select 3, 3, 13, 2, 2017, 7
insert workhours select 3, 3, 14, 2, 2017, 8
insert workhours select 3, 3, 15, 2, 2017, 8
insert workhours select 3, 3, 16, 2, 2017, 9
insert workhours select 3, 3, 17, 2, 2017, 9
insert workhours select 3, 3, 20, 2, 2017, 9
insert workhours select 3, 3, 21, 2, 2017, 9
insert workhours select 3, 3, 22, 2, 2017, 9
insert workhours select 3, 3, 23, 2, 2017, 9
insert workhours select 3, 3, 24, 2, 2017, 9
insert workhours select 3, 3, 27, 2, 2017, 8
insert workhours select 3, 3, 28, 2, 2017, 10
insert workhours select 3, 3, 1, 3, 2017, 6
insert workhours select 3, 3, 2, 3, 2017, 6
insert workhours select 3, 3, 3, 3, 2017, 7
insert workhours select 3, 3, 6, 3, 2017, 8
insert workhours select 3, 3, 7, 3, 2017, 8
insert workhours select 3, 3, 8, 3, 2017, 8
insert workhours select 3, 3, 9, 3, 2017, 8
insert workhours select 3, 3, 10, 3, 2017, 8
insert workhours select 3, 3, 13, 3, 2017, 8
insert workhours select 3, 3, 14, 3, 2017, 8
insert workhours select 3, 3, 15, 3, 2017, 8
insert workhours select 3, 3, 16, 3, 2017, 7
insert workhours select 3, 3, 17, 3, 2017, 7
insert workhours select 3, 3, 20, 3, 2017, 9
insert workhours select 3, 3, 21, 3, 2017, 9
insert workhours select 3, 3, 22, 3, 2017, 9
insert workhours select 3, 3, 23, 3, 2017, 9
insert workhours select 3, 3, 24, 3, 2017, 9
insert workhours select 3, 3, 27, 3, 2017, 9
insert workhours select 3, 3, 28, 3, 2017, 10
insert workhours select 3, 3, 29, 3, 2017, 10
insert workhours select 3, 3, 30, 3, 2017, 10
insert workhours select 3, 3, 31, 3, 2017, 10
insert workhours select 3, 3, 3, 4, 2017, 10
insert workhours select 3, 3, 4, 4, 2017, 10
insert workhours select 3, 3, 5, 4, 2017, 10
insert workhours select 3, 3, 6, 4, 2017, 10
insert workhours select 3, 3, 7, 4, 2017, 9
insert workhours select 3, 3, 10, 4, 2017, 9
insert workhours select 3, 3, 11, 4, 2017, 9
insert workhours select 3, 3, 12, 4, 2017, 9
insert workhours select 3, 3, 13, 4, 2017, 9
insert workhours select 3, 3, 14, 4, 2017, 9
insert workhours select 3, 3, 17, 4, 2017, 9
insert workhours select 3, 3, 18, 4, 2017, 6
insert workhours select 3, 3, 19, 4, 2017, 7
insert workhours select 3, 3, 20, 4, 2017, 8
insert workhours select 3, 3, 21, 4, 2017, 8
insert workhours select 3, 3, 24, 4, 2017, 8
insert workhours select 3, 3, 25, 4, 2017, 8
insert workhours select 3, 3, 26, 4, 2017, 9
insert workhours select 3, 3, 27, 4, 2017, 9
insert workhours select 3, 3, 28, 4, 2017, 9
insert workhours select 3, 3, 1, 5, 2017, 10
insert workhours select 3, 3, 2, 5, 2017, 9
insert workhours select 3, 3, 3, 5, 2017, 9
insert workhours select 3, 3, 4, 5, 2017, 9
insert workhours select 3, 3, 5, 5, 2017, 8
insert workhours select 3, 3, 8, 5, 2017, 8
insert workhours select 3, 3, 9, 5, 2017, 8
insert workhours select 3, 3, 10, 5, 2017, 8
insert workhours select 3, 3, 11, 5, 2017, 8
insert workhours select 3, 3, 12, 5, 2017, 8
insert workhours select 3, 3, 15, 5, 2017, 7
insert workhours select 3, 6, 20, 12, 2016, 10
insert workhours select 3, 6, 21, 12, 2016, 10
insert workhours select 3, 6, 22, 12, 2016, 10
insert workhours select 3, 6, 23, 12, 2016, 9
insert workhours select 3, 6, 26, 12, 2016, 8
insert workhours select 3, 6, 27, 12, 2016, 8
insert workhours select 3, 6, 28, 12, 2016, 8
insert workhours select 3, 6, 29, 12, 2016, 8
insert workhours select 3, 6, 30, 12, 2016, 8
insert workhours select 3, 6, 2, 1, 2017, 8
insert workhours select 3, 6, 3, 1, 2017, 8
insert workhours select 3, 6, 4, 1, 2017, 8
insert workhours select 3, 6, 5, 1, 2017, 8
insert workhours select 3, 6, 6, 1, 2017, 8
insert workhours select 3, 6, 9, 1, 2017, 9
insert workhours select 3, 6, 10, 1, 2017, 9
insert workhours select 3, 6, 11, 1, 2017, 9
insert workhours select 3, 6, 12, 1, 2017, 9
insert workhours select 3, 6, 13, 1, 2017, 10
insert workhours select 3, 6, 16, 1, 2017, 10
insert workhours select 3, 6, 17, 1, 2017, 10
insert workhours select 3, 6, 18, 1, 2017, 10
insert workhours select 3, 6, 19, 1, 2017, 11
insert workhours select 3, 6, 20, 1, 2017, 8
insert workhours select 3, 6, 23, 1, 2017, 8
insert workhours select 3, 6, 24, 1, 2017, 8
insert workhours select 3, 6, 25, 1, 2017, 8
insert workhours select 3, 6, 26, 1, 2017, 7
insert workhours select 3, 6, 27, 1, 2017, 5
insert workhours select 3, 6, 30, 1, 2017, 10
insert workhours select 3, 6, 31, 1, 2017, 10
insert workhours select 3, 6, 1, 2, 2017, 10
insert workhours select 3, 6, 2, 2, 2017, 8
insert workhours select 3, 6, 3, 2, 2017, 7
insert workhours select 3, 6, 6, 2, 2017, 8
insert workhours select 3, 6, 7, 2, 2017, 8
insert workhours select 3, 6, 8, 2, 2017, 9
insert workhours select 3, 6, 9, 2, 2017, 9
insert workhours select 3, 6, 10, 2, 2017, 9
insert workhours select 3, 6, 13, 2, 2017, 9
insert workhours select 3, 6, 14, 2, 2017, 9
insert workhours select 3, 6, 15, 2, 2017, 9
insert workhours select 3, 6, 16, 2, 2017, 9
insert workhours select 3, 6, 17, 2, 2017, 8
insert workhours select 3, 6, 20, 2, 2017, 10
insert workhours select 3, 6, 21, 2, 2017, 6
insert workhours select 3, 6, 22, 2, 2017, 6
insert workhours select 3, 6, 23, 2, 2017, 7
insert workhours select 3, 6, 24, 2, 2017, 8
insert workhours select 3, 6, 27, 2, 2017, 8
insert workhours select 3, 6, 28, 2, 2017, 8
insert workhours select 3, 6, 1, 3, 2017, 8
insert workhours select 3, 6, 2, 3, 2017, 8
insert workhours select 3, 6, 3, 3, 2017, 8
insert workhours select 3, 6, 6, 3, 2017, 8
insert workhours select 3, 6, 7, 3, 2017, 8
insert workhours select 3, 6, 8, 3, 2017, 7
insert workhours select 3, 6, 9, 3, 2017, 7
insert workhours select 3, 6, 10, 3, 2017, 9
insert workhours select 3, 6, 13, 3, 2017, 9
insert workhours select 3, 6, 14, 3, 2017, 9
insert workhours select 3, 6, 15, 3, 2017, 9
insert workhours select 3, 6, 16, 3, 2017, 9
insert workhours select 3, 6, 17, 3, 2017, 9
insert workhours select 3, 6, 20, 3, 2017, 10
insert workhours select 3, 6, 21, 3, 2017, 10
insert workhours select 3, 6, 22, 3, 2017, 10
insert workhours select 3, 6, 23, 3, 2017, 10
insert workhours select 3, 6, 24, 3, 2017, 10
insert workhours select 3, 6, 27, 3, 2017, 10
insert workhours select 3, 6, 28, 3, 2017, 10
insert workhours select 3, 6, 29, 3, 2017, 10
insert workhours select 3, 6, 30, 3, 2017, 9
insert workhours select 3, 6, 31, 3, 2017, 9
insert workhours select 3, 6, 3, 4, 2017, 9
insert workhours select 3, 6, 4, 4, 2017, 9
insert workhours select 3, 6, 5, 4, 2017, 9
insert workhours select 3, 6, 6, 4, 2017, 9
insert workhours select 3, 6, 7, 4, 2017, 9
insert workhours select 3, 6, 10, 4, 2017, 6
insert workhours select 3, 6, 11, 4, 2017, 7
insert workhours select 3, 6, 12, 4, 2017, 8
insert workhours select 3, 6, 13, 4, 2017, 8
insert workhours select 3, 6, 14, 4, 2017, 8
insert workhours select 3, 6, 17, 4, 2017, 8
insert workhours select 3, 6, 18, 4, 2017, 9
insert workhours select 3, 6, 19, 4, 2017, 9
insert workhours select 3, 6, 20, 4, 2017, 9
insert workhours select 3, 6, 21, 4, 2017, 10
insert workhours select 3, 6, 24, 4, 2017, 9
insert workhours select 3, 6, 25, 4, 2017, 9
insert workhours select 3, 6, 26, 4, 2017, 9
insert workhours select 3, 6, 27, 4, 2017, 8
insert workhours select 3, 6, 28, 4, 2017, 8
insert workhours select 3, 6, 1, 5, 2017, 8
insert workhours select 3, 6, 2, 5, 2017, 8
insert workhours select 3, 6, 3, 5, 2017, 8
insert workhours select 3, 6, 4, 5, 2017, 8
insert workhours select 3, 6, 5, 5, 2017, 7
insert workhours select 3, 6, 8, 5, 2017, 10
insert workhours select 3, 6, 9, 5, 2017, 10
insert workhours select 3, 6, 10, 5, 2017, 10
insert workhours select 3, 6, 11, 5, 2017, 9
insert workhours select 3, 6, 12, 5, 2017, 8
insert workhours select 3, 6, 15, 5, 2017, 8
insert workhours select 3, 7, 20, 12, 2016, 8
insert workhours select 3, 7, 21, 12, 2016, 8
insert workhours select 3, 7, 22, 12, 2016, 8
insert workhours select 3, 7, 23, 12, 2016, 8
insert workhours select 3, 7, 26, 12, 2016, 8
insert workhours select 3, 7, 27, 12, 2016, 8
insert workhours select 3, 7, 28, 12, 2016, 8
insert workhours select 3, 7, 29, 12, 2016, 8
insert workhours select 3, 7, 30, 12, 2016, 9
insert workhours select 3, 7, 2, 1, 2017, 9
insert workhours select 3, 7, 3, 1, 2017, 9
insert workhours select 3, 7, 4, 1, 2017, 9
insert workhours select 3, 7, 5, 1, 2017, 10
insert workhours select 3, 7, 6, 1, 2017, 10
insert workhours select 3, 7, 9, 1, 2017, 10
insert workhours select 3, 7, 10, 1, 2017, 10
insert workhours select 3, 7, 11, 1, 2017, 11
insert workhours select 3, 7, 12, 1, 2017, 8
insert workhours select 3, 7, 13, 1, 2017, 8
insert workhours select 3, 7, 16, 1, 2017, 8
insert workhours select 3, 7, 17, 1, 2017, 8
insert workhours select 3, 7, 18, 1, 2017, 7
insert workhours select 3, 7, 19, 1, 2017, 5
insert workhours select 3, 7, 20, 1, 2017, 10
insert workhours select 3, 7, 23, 1, 2017, 10
insert workhours select 3, 7, 24, 1, 2017, 10
insert workhours select 3, 7, 25, 1, 2017, 8
insert workhours select 3, 7, 26, 1, 2017, 7
insert workhours select 3, 7, 27, 1, 2017, 8
insert workhours select 3, 7, 30, 1, 2017, 8
insert workhours select 3, 7, 31, 1, 2017, 9
insert workhours select 3, 7, 1, 2, 2017, 9
insert workhours select 3, 7, 2, 2, 2017, 9
insert workhours select 3, 7, 3, 2, 2017, 9
insert workhours select 3, 7, 6, 2, 2017, 9
insert workhours select 3, 7, 7, 2, 2017, 9
insert workhours select 3, 7, 8, 2, 2017, 9
insert workhours select 3, 7, 9, 2, 2017, 8
insert workhours select 3, 7, 10, 2, 2017, 10
insert workhours select 3, 7, 13, 2, 2017, 6
insert workhours select 3, 7, 14, 2, 2017, 6
insert workhours select 3, 7, 15, 2, 2017, 7
insert workhours select 3, 7, 16, 2, 2017, 8
insert workhours select 3, 7, 17, 2, 2017, 8
insert workhours select 3, 7, 20, 2, 2017, 8
insert workhours select 3, 7, 21, 2, 2017, 8
insert workhours select 3, 7, 22, 2, 2017, 8
insert workhours select 3, 7, 23, 2, 2017, 8
insert workhours select 3, 7, 24, 2, 2017, 8
insert workhours select 3, 7, 27, 2, 2017, 8
insert workhours select 3, 7, 28, 2, 2017, 7
insert workhours select 3, 7, 1, 3, 2017, 7
insert workhours select 3, 7, 2, 3, 2017, 9
insert workhours select 3, 7, 3, 3, 2017, 9
insert workhours select 3, 7, 6, 3, 2017, 9
insert workhours select 3, 7, 7, 3, 2017, 9
insert workhours select 3, 7, 8, 3, 2017, 9
insert workhours select 3, 7, 9, 3, 2017, 9
insert workhours select 3, 7, 10, 3, 2017, 10
insert workhours select 3, 7, 13, 3, 2017, 10
insert workhours select 3, 7, 14, 3, 2017, 10
insert workhours select 3, 7, 15, 3, 2017, 10
insert workhours select 3, 7, 16, 3, 2017, 10
insert workhours select 3, 7, 17, 3, 2017, 10
insert workhours select 3, 7, 20, 3, 2017, 10
insert workhours select 3, 7, 21, 3, 2017, 10
insert workhours select 3, 7, 22, 3, 2017, 9
insert workhours select 3, 7, 23, 3, 2017, 9
insert workhours select 3, 7, 24, 3, 2017, 9
insert workhours select 3, 7, 27, 3, 2017, 9
insert workhours select 3, 7, 28, 3, 2017, 9
insert workhours select 3, 7, 29, 3, 2017, 9
insert workhours select 3, 7, 30, 3, 2017, 9
insert workhours select 3, 7, 31, 3, 2017, 6
insert workhours select 3, 7, 3, 4, 2017, 7
insert workhours select 3, 7, 4, 4, 2017, 8
insert workhours select 3, 7, 5, 4, 2017, 8
insert workhours select 3, 7, 6, 4, 2017, 8
insert workhours select 3, 7, 7, 4, 2017, 8
insert workhours select 3, 7, 10, 4, 2017, 9
insert workhours select 3, 7, 11, 4, 2017, 9
insert workhours select 3, 7, 12, 4, 2017, 9
insert workhours select 3, 7, 13, 4, 2017, 10
insert workhours select 3, 7, 14, 4, 2017, 9
insert workhours select 3, 7, 17, 4, 2017, 9
insert workhours select 3, 7, 18, 4, 2017, 9
insert workhours select 3, 7, 19, 4, 2017, 8
insert workhours select 3, 7, 20, 4, 2017, 8
insert workhours select 3, 7, 21, 4, 2017, 8
insert workhours select 3, 7, 24, 4, 2017, 8
insert workhours select 3, 7, 25, 4, 2017, 8
insert workhours select 3, 7, 26, 4, 2017, 8
insert workhours select 3, 7, 27, 4, 2017, 8
insert workhours select 3, 7, 28, 4, 2017, 8
insert workhours select 3, 7, 1, 5, 2017, 8
insert workhours select 3, 7, 2, 5, 2017, 8
insert workhours select 3, 7, 3, 5, 2017, 7
insert workhours select 3, 7, 4, 5, 2017, 10
insert workhours select 3, 7, 5, 5, 2017, 10
insert workhours select 3, 7, 8, 5, 2017, 10
insert workhours select 3, 7, 9, 5, 2017, 9
insert workhours select 3, 7, 10, 5, 2017, 8
insert workhours select 3, 7, 11, 5, 2017, 8
insert workhours select 3, 7, 12, 5, 2017, 8
insert workhours select 3, 7, 15, 5, 2017, 8
insert workhours select 4, 4, 23, 6, 2017, 8
insert workhours select 4, 4, 24, 6, 2017, 8
insert workhours select 4, 4, 26, 6, 2017, 8
insert workhours select 4, 4, 27, 6, 2017, 8
insert workhours select 4, 4, 28, 6, 2017, 8
insert workhours select 4, 4, 29, 6, 2017, 8
insert workhours select 4, 4, 30, 6, 2017, 9
insert workhours select 4, 4, 1, 7, 2017, 9
insert workhours select 4, 2, 16, 5, 2017, 9
insert workhours select 4, 2, 17, 5, 2017, 9
insert workhours select 4, 2, 18, 5, 2017, 10
insert workhours select 4, 2, 19, 5, 2017, 10
insert workhours select 4, 2, 22, 5, 2017, 10
insert workhours select 4, 2, 23, 5, 2017, 10
insert workhours select 4, 2, 24, 5, 2017, 11
insert workhours select 4, 2, 25, 5, 2017, 8
insert workhours select 4, 2, 26, 5, 2017, 8
insert workhours select 4, 2, 29, 5, 2017, 8
insert workhours select 4, 2, 30, 5, 2017, 8
insert workhours select 4, 2, 31, 5, 2017, 7
insert workhours select 4, 2, 1, 6, 2017, 5
insert workhours select 4, 2, 2, 6, 2017, 10
insert workhours select 4, 2, 5, 6, 2017, 10
insert workhours select 4, 2, 6, 6, 2017, 10
insert workhours select 4, 2, 7, 6, 2017, 8
insert workhours select 4, 2, 8, 6, 2017, 7
insert workhours select 4, 2, 9, 6, 2017, 8
insert workhours select 4, 2, 12, 6, 2017, 8
insert workhours select 4, 2, 13, 6, 2017, 9
insert workhours select 4, 2, 14, 6, 2017, 9
insert workhours select 4, 2, 15, 6, 2017, 9
insert workhours select 4, 2, 16, 6, 2017, 9
insert workhours select 4, 2, 19, 6, 2017, 9
insert workhours select 4, 2, 20, 6, 2017, 9
insert workhours select 4, 2, 21, 6, 2017, 9
insert workhours select 4, 2, 22, 6, 2017, 8
insert workhours select 4, 2, 23, 6, 2017, 10
insert workhours select 4, 2, 26, 6, 2017, 6
insert workhours select 4, 2, 27, 6, 2017, 6
insert workhours select 4, 2, 28, 6, 2017, 7
insert workhours select 4, 2, 29, 6, 2017, 8
insert workhours select 4, 2, 30, 6, 2017, 8
insert workhours select 4, 2, 3, 7, 2017, 8
insert workhours select 4, 2, 4, 7, 2017, 8
insert workhours select 4, 2, 5, 7, 2017, 8
insert workhours select 4, 2, 6, 7, 2017, 8
insert workhours select 4, 2, 7, 7, 2017, 8
insert workhours select 4, 2, 10, 7, 2017, 8
insert workhours select 4, 2, 11, 7, 2017, 7
insert workhours select 4, 2, 12, 7, 2017, 7
insert workhours select 4, 2, 13, 7, 2017, 9
insert workhours select 4, 2, 14, 7, 2017, 9
insert workhours select 4, 2, 17, 7, 2017, 9
insert workhours select 4, 2, 18, 7, 2017, 9
insert workhours select 4, 2, 19, 7, 2017, 9
insert workhours select 4, 2, 20, 7, 2017, 9
insert workhours select 4, 2, 21, 7, 2017, 10
insert workhours select 4, 2, 24, 7, 2017, 10
insert workhours select 4, 2, 25, 7, 2017, 10
insert workhours select 4, 2, 26, 7, 2017, 10
insert workhours select 4, 2, 27, 7, 2017, 10
insert workhours select 4, 2, 28, 7, 2017, 10
insert workhours select 4, 2, 31, 7, 2017, 10
insert workhours select 4, 2, 1, 8, 2017, 10
insert workhours select 4, 2, 2, 8, 2017, 9
insert workhours select 4, 2, 3, 8, 2017, 9
insert workhours select 4, 2, 4, 8, 2017, 9
insert workhours select 4, 2, 7, 8, 2017, 9
insert workhours select 4, 2, 8, 8, 2017, 9
insert workhours select 4, 2, 9, 8, 2017, 9
insert workhours select 4, 2, 10, 8, 2017, 9
insert workhours select 4, 2, 11, 8, 2017, 6
insert workhours select 4, 2, 14, 8, 2017, 7
insert workhours select 4, 2, 15, 8, 2017, 8
insert workhours select 4, 2, 16, 8, 2017, 8
insert workhours select 4, 2, 17, 8, 2017, 8
insert workhours select 4, 2, 18, 8, 2017, 8
insert workhours select 4, 2, 21, 8, 2017, 9
insert workhours select 4, 2, 22, 8, 2017, 9
insert workhours select 4, 2, 23, 8, 2017, 9
insert workhours select 4, 2, 24, 8, 2017, 10
insert workhours select 4, 2, 25, 8, 2017, 9
insert workhours select 4, 2, 28, 8, 2017, 9
insert workhours select 4, 2, 29, 8, 2017, 9
insert workhours select 4, 2, 30, 8, 2017, 8
insert workhours select 4, 2, 31, 8, 2017, 8
insert workhours select 4, 2, 1, 9, 2017, 8
insert workhours select 4, 2, 4, 9, 2017, 8
insert workhours select 4, 2, 5, 9, 2017, 8
insert workhours select 4, 2, 6, 9, 2017, 8
insert workhours select 4, 2, 7, 9, 2017, 8
insert workhours select 4, 2, 8, 9, 2017, 8
insert workhours select 4, 2, 11, 9, 2017, 8
insert workhours select 4, 2, 12, 9, 2017, 7
insert workhours select 4, 2, 13, 9, 2017, 10
insert workhours select 4, 2, 14, 9, 2017, 10
insert workhours select 4, 2, 15, 9, 2017, 10
insert workhours select 4, 2, 18, 9, 2017, 9
insert workhours select 4, 2, 19, 9, 2017, 8
insert workhours select 4, 2, 20, 9, 2017, 8
insert workhours select 4, 2, 21, 9, 2017, 8
insert workhours select 4, 2, 22, 9, 2017, 8
insert workhours select 4, 2, 25, 9, 2017, 8
insert workhours select 4, 2, 26, 9, 2017, 8
insert workhours select 4, 2, 27, 9, 2017, 8
insert workhours select 4, 2, 28, 9, 2017, 8
insert workhours select 4, 2, 29, 9, 2017, 8
insert workhours select 5, 7, 18, 10, 2016, 8
insert workhours select 5, 7, 19, 10, 2016, 9
insert workhours select 5, 7, 20, 10, 2016, 9
insert workhours select 5, 7, 21, 10, 2016, 9
insert workhours select 5, 7, 24, 10, 2016, 9
insert workhours select 5, 7, 25, 10, 2016, 10
insert workhours select 5, 7, 26, 10, 2016, 10
insert workhours select 5, 7, 27, 10, 2016, 10
insert workhours select 5, 7, 28, 10, 2016, 10
insert workhours select 5, 7, 31, 10, 2016, 11
insert workhours select 5, 7, 1, 11, 2016, 8
insert workhours select 5, 7, 2, 11, 2016, 8
insert workhours select 5, 7, 3, 11, 2016, 8
insert workhours select 5, 7, 4, 11, 2016, 8
insert workhours select 5, 7, 7, 11, 2016, 7
insert workhours select 5, 7, 8, 11, 2016, 5
insert workhours select 5, 7, 9, 11, 2016, 10
insert workhours select 5, 7, 10, 11, 2016, 10
insert workhours select 5, 7, 11, 11, 2016, 10
insert workhours select 5, 7, 14, 11, 2016, 8
insert workhours select 5, 7, 15, 11, 2016, 7
insert workhours select 5, 7, 16, 11, 2016, 8
insert workhours select 5, 7, 17, 11, 2016, 8
insert workhours select 5, 7, 18, 11, 2016, 9
insert workhours select 5, 7, 21, 11, 2016, 9
insert workhours select 5, 7, 22, 11, 2016, 9
insert workhours select 5, 7, 23, 11, 2016, 9
insert workhours select 5, 7, 24, 11, 2016, 9
insert workhours select 5, 7, 25, 11, 2016, 9
insert workhours select 5, 7, 28, 11, 2016, 9
insert workhours select 5, 7, 29, 11, 2016, 8
insert workhours select 5, 7, 30, 11, 2016, 10
insert workhours select 5, 7, 1, 12, 2016, 6
insert workhours select 5, 7, 2, 12, 2016, 6
insert workhours select 5, 7, 5, 12, 2016, 7
insert workhours select 5, 7, 6, 12, 2016, 8
insert workhours select 5, 7, 7, 12, 2016, 8
insert workhours select 5, 7, 8, 12, 2016, 8
insert workhours select 5, 7, 9, 12, 2016, 8
insert workhours select 5, 7, 12, 12, 2016, 8
insert workhours select 5, 7, 13, 12, 2016, 8
insert workhours select 5, 7, 14, 12, 2016, 8
insert workhours select 5, 7, 15, 12, 2016, 8
insert workhours select 5, 7, 16, 12, 2016, 7
insert workhours select 5, 7, 19, 12, 2016, 7
insert workhours select 5, 7, 20, 12, 2016, 9
insert workhours select 5, 7, 21, 12, 2016, 9
insert workhours select 5, 7, 22, 12, 2016, 9
insert workhours select 5, 7, 23, 12, 2016, 9
insert workhours select 5, 7, 26, 12, 2016, 9
insert workhours select 5, 7, 27, 12, 2016, 9
insert workhours select 5, 7, 28, 12, 2016, 10
insert workhours select 5, 7, 29, 12, 2016, 10
insert workhours select 5, 7, 30, 12, 2016, 10
insert workhours select 5, 7, 2, 1, 2017, 10
insert workhours select 5, 7, 3, 1, 2017, 10
insert workhours select 5, 7, 4, 1, 2017, 10
insert workhours select 5, 7, 5, 1, 2017, 10
insert workhours select 5, 7, 6, 1, 2017, 10
insert workhours select 5, 7, 9, 1, 2017, 9
insert workhours select 5, 7, 10, 1, 2017, 9
insert workhours select 5, 7, 11, 1, 2017, 9
insert workhours select 5, 7, 12, 1, 2017, 9
insert workhours select 5, 7, 13, 1, 2017, 9
insert workhours select 5, 7, 16, 1, 2017, 9
insert workhours select 5, 7, 17, 1, 2017, 9
insert workhours select 5, 7, 18, 1, 2017, 6
insert workhours select 5, 7, 19, 1, 2017, 7
insert workhours select 5, 7, 20, 1, 2017, 8
insert workhours select 5, 7, 23, 1, 2017, 8
insert workhours select 5, 7, 24, 1, 2017, 8
insert workhours select 5, 7, 25, 1, 2017, 8
insert workhours select 5, 7, 26, 1, 2017, 9
insert workhours select 5, 7, 27, 1, 2017, 9
insert workhours select 5, 7, 30, 1, 2017, 9
insert workhours select 5, 7, 31, 1, 2017, 10
insert workhours select 5, 7, 1, 2, 2017, 9
insert workhours select 5, 7, 2, 2, 2017, 9
insert workhours select 5, 7, 3, 2, 2017, 9
insert workhours select 5, 7, 6, 2, 2017, 8
insert workhours select 5, 7, 7, 2, 2017, 8
insert workhours select 5, 7, 8, 2, 2017, 8
insert workhours select 5, 7, 9, 2, 2017, 8
insert workhours select 5, 7, 10, 2, 2017, 8
insert workhours select 5, 7, 13, 2, 2017, 8
insert workhours select 5, 7, 14, 2, 2017, 8
insert workhours select 5, 7, 15, 2, 2017, 8
insert workhours select 5, 7, 16, 2, 2017, 7
insert workhours select 5, 7, 17, 2, 2017, 10
insert workhours select 5, 7, 20, 2, 2017, 10
insert workhours select 5, 7, 21, 2, 2017, 10
insert workhours select 5, 7, 22, 2, 2017, 9
insert workhours select 5, 7, 23, 2, 2017, 8
insert workhours select 5, 7, 24, 2, 2017, 8
insert workhours select 5, 7, 27, 2, 2017, 8
insert workhours select 5, 7, 28, 2, 2017, 8
insert workhours select 5, 7, 1, 3, 2017, 8
insert workhours select 5, 7, 2, 3, 2017, 8
insert workhours select 5, 7, 3, 3, 2017, 8
insert workhours select 5, 7, 6, 3, 2017, 8
insert workhours select 5, 7, 7, 3, 2017, 8
insert workhours select 5, 7, 8, 3, 2017, 8
insert workhours select 5, 7, 9, 3, 2017, 9
insert workhours select 5, 7, 10, 3, 2017, 9
insert workhours select 5, 7, 13, 3, 2017, 9
insert workhours select 5, 7, 14, 3, 2017, 9
insert workhours select 5, 7, 15, 3, 2017, 10
insert workhours select 5, 7, 16, 3, 2017, 10
insert workhours select 5, 7, 17, 3, 2017, 10
insert workhours select 5, 7, 20, 3, 2017, 10
insert workhours select 5, 7, 21, 3, 2017, 11
insert workhours select 5, 7, 22, 3, 2017, 8
insert workhours select 5, 7, 23, 3, 2017, 8
insert workhours select 5, 7, 24, 3, 2017, 8
insert workhours select 5, 7, 27, 3, 2017, 8
insert workhours select 5, 7, 28, 3, 2017, 7
insert workhours select 5, 7, 29, 3, 2017, 5
insert workhours select 5, 7, 30, 3, 2017, 10
insert workhours select 5, 7, 31, 3, 2017, 10
insert workhours select 5, 7, 3, 4, 2017, 10
insert workhours select 5, 7, 4, 4, 2017, 8
insert workhours select 5, 7, 5, 4, 2017, 7
insert workhours select 5, 7, 6, 4, 2017, 8
insert workhours select 5, 7, 7, 4, 2017, 8
insert workhours select 5, 7, 10, 4, 2017, 9
insert workhours select 5, 7, 11, 4, 2017, 9
insert workhours select 5, 7, 12, 4, 2017, 9
insert workhours select 5, 7, 13, 4, 2017, 9
insert workhours select 5, 7, 14, 4, 2017, 9
insert workhours select 5, 7, 17, 4, 2017, 9
insert workhours select 5, 7, 18, 4, 2017, 9
insert workhours select 5, 7, 19, 4, 2017, 8
insert workhours select 5, 7, 20, 4, 2017, 10
insert workhours select 5, 7, 21, 4, 2017, 6
insert workhours select 5, 7, 24, 4, 2017, 6
insert workhours select 5, 7, 25, 4, 2017, 7
insert workhours select 5, 7, 26, 4, 2017, 8
insert workhours select 5, 7, 27, 4, 2017, 8
insert workhours select 5, 7, 28, 4, 2017, 8
insert workhours select 5, 7, 1, 5, 2017, 8
insert workhours select 5, 7, 2, 5, 2017, 8
insert workhours select 5, 7, 3, 5, 2017, 8
insert workhours select 5, 7, 4, 5, 2017, 8
insert workhours select 5, 7, 5, 5, 2017, 8
insert workhours select 5, 7, 8, 5, 2017, 7
insert workhours select 5, 7, 9, 5, 2017, 7
insert workhours select 5, 7, 10, 5, 2017, 9
insert workhours select 5, 7, 11, 5, 2017, 9
insert workhours select 5, 7, 12, 5, 2017, 9
insert workhours select 5, 7, 15, 5, 2017, 9
insert workhours select 5, 7, 16, 5, 2017, 9
insert workhours select 5, 7, 17, 5, 2017, 9
insert workhours select 5, 7, 18, 5, 2017, 10
insert workhours select 5, 7, 19, 5, 2017, 10
insert workhours select 5, 7, 22, 5, 2017, 10
insert workhours select 5, 7, 23, 5, 2017, 10
insert workhours select 5, 7, 24, 5, 2017, 10
insert workhours select 5, 7, 25, 5, 2017, 10
insert workhours select 5, 7, 26, 5, 2017, 10
insert workhours select 5, 7, 29, 5, 2017, 10
insert workhours select 5, 7, 30, 5, 2017, 9
insert workhours select 5, 7, 31, 5, 2017, 9
insert workhours select 5, 7, 1, 6, 2017, 9
insert workhours select 5, 7, 2, 6, 2017, 9
insert workhours select 5, 7, 5, 6, 2017, 9
insert workhours select 5, 7, 6, 6, 2017, 9
insert workhours select 5, 7, 7, 6, 2017, 9
insert workhours select 5, 7, 8, 6, 2017, 6
insert workhours select 5, 7, 9, 6, 2017, 7
insert workhours select 5, 7, 12, 6, 2017, 8
insert workhours select 5, 7, 13, 6, 2017, 8
insert workhours select 5, 7, 14, 6, 2017, 8
insert workhours select 5, 7, 15, 6, 2017, 8
insert workhours select 5, 7, 16, 6, 2017, 9
insert workhours select 5, 7, 19, 6, 2017, 9
insert workhours select 5, 7, 20, 6, 2017, 9
insert workhours select 5, 7, 21, 6, 2017, 10
insert workhours select 5, 7, 22, 6, 2017, 9
insert workhours select 5, 7, 23, 6, 2017, 9
insert workhours select 5, 7, 26, 6, 2017, 9
insert workhours select 5, 7, 27, 6, 2017, 8
insert workhours select 5, 7, 28, 6, 2017, 8
insert workhours select 5, 7, 29, 6, 2017, 8
insert workhours select 5, 7, 30, 6, 2017, 8
insert workhours select 5, 7, 3, 7, 2017, 8
insert workhours select 5, 7, 4, 7, 2017, 8
insert workhours select 5, 7, 5, 7, 2017, 8
insert workhours select 5, 7, 6, 7, 2017, 8
insert workhours select 5, 7, 7, 7, 2017, 8
insert workhours select 5, 7, 10, 7, 2017, 8
insert workhours select 5, 7, 11, 7, 2017, 8
insert workhours select 5, 7, 12, 7, 2017, 8
insert workhours select 5, 7, 13, 7, 2017, 8
insert workhours select 5, 7, 14, 7, 2017, 8
insert workhours select 5, 7, 17, 7, 2017, 7
insert workhours select 5, 7, 18, 7, 2017, 10
insert workhours select 5, 7, 19, 7, 2017, 10
insert workhours select 5, 7, 20, 7, 2017, 10
insert workhours select 5, 7, 21, 7, 2017, 9
insert workhours select 5, 7, 24, 7, 2017, 8
insert workhours select 5, 7, 25, 7, 2017, 8
insert workhours select 5, 7, 26, 7, 2017, 8
insert workhours select 5, 7, 27, 7, 2017, 8
insert workhours select 5, 7, 28, 7, 2017, 8
insert workhours select 5, 7, 31, 7, 2017, 8
insert workhours select 5, 7, 1, 8, 2017, 8
insert workhours select 5, 7, 2, 8, 2017, 8
insert workhours select 5, 7, 3, 8, 2017, 8
insert workhours select 5, 7, 4, 8, 2017, 8
insert workhours select 5, 7, 7, 8, 2017, 9
insert workhours select 5, 7, 8, 8, 2017, 9
insert workhours select 5, 7, 9, 8, 2017, 9
insert workhours select 5, 7, 10, 8, 2017, 9
insert workhours select 5, 7, 11, 8, 2017, 10
insert workhours select 5, 7, 14, 8, 2017, 10
insert workhours select 5, 7, 15, 8, 2017, 10
insert workhours select 5, 7, 16, 8, 2017, 10
insert workhours select 5, 7, 17, 8, 2017, 11
insert workhours select 5, 7, 18, 8, 2017, 8
insert workhours select 5, 7, 21, 8, 2017, 8
insert workhours select 5, 7, 22, 8, 2017, 8
insert workhours select 5, 7, 23, 8, 2017, 8
insert workhours select 5, 7, 24, 8, 2017, 7
insert workhours select 5, 7, 25, 8, 2017, 5
insert workhours select 5, 7, 28, 8, 2017, 10
insert workhours select 5, 7, 29, 8, 2017, 10
insert workhours select 5, 7, 30, 8, 2017, 10
insert workhours select 5, 7, 31, 8, 2017, 8
insert workhours select 5, 7, 1, 9, 2017, 7
insert workhours select 5, 7, 4, 9, 2017, 8
insert workhours select 5, 7, 5, 9, 2017, 8
insert workhours select 5, 7, 6, 9, 2017, 9
insert workhours select 5, 7, 7, 9, 2017, 9
insert workhours select 5, 7, 8, 9, 2017, 9
insert workhours select 5, 7, 11, 9, 2017, 9
insert workhours select 5, 7, 12, 9, 2017, 9
insert workhours select 5, 7, 13, 9, 2017, 9
insert workhours select 5, 7, 14, 9, 2017, 9
insert workhours select 5, 7, 15, 9, 2017, 8
insert workhours select 5, 7, 18, 9, 2017, 10
insert workhours select 5, 7, 19, 9, 2017, 6
insert workhours select 5, 7, 20, 9, 2017, 6
insert workhours select 5, 7, 21, 9, 2017, 7
insert workhours select 5, 7, 22, 9, 2017, 8
insert workhours select 5, 7, 25, 9, 2017, 8
insert workhours select 5, 7, 26, 9, 2017, 8
insert workhours select 5, 7, 27, 9, 2017, 8
insert workhours select 5, 7, 28, 9, 2017, 8
insert workhours select 5, 7, 29, 9, 2017, 8
insert workhours select 5, 8, 18, 10, 2016, 8
insert workhours select 5, 8, 19, 10, 2016, 8
insert workhours select 5, 8, 20, 10, 2016, 7
insert workhours select 5, 8, 21, 10, 2016, 7
insert workhours select 5, 8, 24, 10, 2016, 9
insert workhours select 5, 8, 25, 10, 2016, 9
insert workhours select 5, 8, 26, 10, 2016, 9
insert workhours select 5, 8, 27, 10, 2016, 9
insert workhours select 5, 8, 28, 10, 2016, 9
insert workhours select 5, 8, 31, 10, 2016, 9
insert workhours select 5, 8, 1, 11, 2016, 10
insert workhours select 5, 8, 2, 11, 2016, 10
insert workhours select 5, 8, 3, 11, 2016, 10
insert workhours select 5, 8, 4, 11, 2016, 10
insert workhours select 5, 8, 7, 11, 2016, 10
insert workhours select 5, 8, 8, 11, 2016, 10
insert workhours select 5, 8, 9, 11, 2016, 10
insert workhours select 5, 8, 10, 11, 2016, 10
insert workhours select 5, 8, 11, 11, 2016, 9
insert workhours select 5, 8, 14, 11, 2016, 9
insert workhours select 5, 8, 15, 11, 2016, 9
insert workhours select 5, 8, 16, 11, 2016, 9
insert workhours select 5, 8, 17, 11, 2016, 9
insert workhours select 5, 8, 18, 11, 2016, 9
insert workhours select 5, 8, 21, 11, 2016, 9
insert workhours select 5, 8, 22, 11, 2016, 8
insert workhours select 5, 8, 23, 11, 2016, 8
insert workhours select 5, 8, 24, 11, 2016, 8
insert workhours select 5, 8, 25, 11, 2016, 8
insert workhours select 5, 8, 28, 11, 2016, 8
insert workhours select 5, 8, 29, 11, 2016, 7
insert workhours select 5, 8, 30, 11, 2016, 10
insert workhours select 5, 8, 1, 12, 2016, 10
insert workhours select 5, 8, 2, 12, 2016, 10
insert workhours select 5, 8, 5, 12, 2016, 9
insert workhours select 5, 8, 6, 12, 2016, 8
insert workhours select 5, 8, 7, 12, 2016, 8
insert workhours select 5, 8, 8, 12, 2016, 8
insert workhours select 5, 8, 9, 12, 2016, 8
insert workhours select 5, 8, 12, 12, 2016, 8
insert workhours select 5, 8, 13, 12, 2016, 8
insert workhours select 5, 8, 14, 12, 2016, 8
insert workhours select 5, 8, 15, 12, 2016, 8
insert workhours select 5, 8, 16, 12, 2016, 8
insert workhours select 5, 8, 19, 12, 2016, 8
insert workhours select 5, 8, 20, 12, 2016, 9
insert workhours select 5, 8, 21, 12, 2016, 9
insert workhours select 5, 8, 22, 12, 2016, 9
insert workhours select 5, 8, 23, 12, 2016, 9
insert workhours select 5, 8, 26, 12, 2016, 10
insert workhours select 5, 8, 27, 12, 2016, 10
insert workhours select 5, 8, 28, 12, 2016, 10
insert workhours select 5, 8, 29, 12, 2016, 10
insert workhours select 5, 8, 30, 12, 2016, 11
insert workhours select 5, 8, 2, 1, 2017, 8
insert workhours select 5, 8, 3, 1, 2017, 8
insert workhours select 5, 8, 4, 1, 2017, 8
insert workhours select 5, 8, 5, 1, 2017, 8
insert workhours select 5, 8, 6, 1, 2017, 7
insert workhours select 5, 8, 9, 1, 2017, 5
insert workhours select 5, 8, 10, 1, 2017, 10
insert workhours select 5, 8, 11, 1, 2017, 10
insert workhours select 5, 8, 12, 1, 2017, 10
insert workhours select 5, 8, 13, 1, 2017, 8
insert workhours select 5, 8, 16, 1, 2017, 7
insert workhours select 5, 8, 17, 1, 2017, 8
insert workhours select 5, 8, 18, 1, 2017, 8
insert workhours select 5, 8, 19, 1, 2017, 9
insert workhours select 5, 8, 20, 1, 2017, 9
insert workhours select 5, 8, 23, 1, 2017, 9
insert workhours select 5, 8, 24, 1, 2017, 9
insert workhours select 5, 8, 25, 1, 2017, 9
insert workhours select 5, 8, 26, 1, 2017, 9
insert workhours select 5, 8, 27, 1, 2017, 9
insert workhours select 5, 8, 30, 1, 2017, 8
insert workhours select 5, 8, 31, 1, 2017, 10
insert workhours select 5, 8, 1, 2, 2017, 6
insert workhours select 5, 8, 2, 2, 2017, 6
insert workhours select 5, 8, 3, 2, 2017, 7
insert workhours select 5, 8, 6, 2, 2017, 8
insert workhours select 5, 8, 7, 2, 2017, 8
insert workhours select 5, 8, 8, 2, 2017, 8
insert workhours select 5, 8, 9, 2, 2017, 8
insert workhours select 5, 8, 10, 2, 2017, 8
insert workhours select 5, 8, 13, 2, 2017, 8
insert workhours select 5, 8, 14, 2, 2017, 8
insert workhours select 5, 8, 15, 2, 2017, 8
insert workhours select 5, 8, 16, 2, 2017, 7
insert workhours select 5, 8, 17, 2, 2017, 7
insert workhours select 5, 8, 20, 2, 2017, 9
insert workhours select 5, 8, 21, 2, 2017, 9
insert workhours select 5, 8, 22, 2, 2017, 9
insert workhours select 5, 8, 23, 2, 2017, 9
insert workhours select 5, 8, 24, 2, 2017, 9
insert workhours select 5, 8, 27, 2, 2017, 9
insert workhours select 5, 8, 28, 2, 2017, 10
insert workhours select 5, 8, 1, 3, 2017, 10
insert workhours select 5, 8, 2, 3, 2017, 10
insert workhours select 5, 8, 3, 3, 2017, 10
insert workhours select 5, 8, 6, 3, 2017, 10
insert workhours select 5, 8, 7, 3, 2017, 10
insert workhours select 5, 8, 8, 3, 2017, 10
insert workhours select 5, 8, 9, 3, 2017, 10
insert workhours select 5, 8, 10, 3, 2017, 9
insert workhours select 5, 8, 13, 3, 2017, 9
insert workhours select 5, 8, 14, 3, 2017, 9
insert workhours select 5, 8, 15, 3, 2017, 9
insert workhours select 5, 8, 16, 3, 2017, 9
insert workhours select 5, 8, 17, 3, 2017, 9
insert workhours select 5, 8, 20, 3, 2017, 9
insert workhours select 5, 8, 21, 3, 2017, 6
insert workhours select 5, 8, 22, 3, 2017, 7
insert workhours select 5, 8, 23, 3, 2017, 8
insert workhours select 5, 8, 24, 3, 2017, 8
insert workhours select 5, 8, 27, 3, 2017, 8
insert workhours select 5, 8, 28, 3, 2017, 8
insert workhours select 5, 8, 29, 3, 2017, 9
insert workhours select 5, 8, 30, 3, 2017, 9
insert workhours select 5, 8, 31, 3, 2017, 9
insert workhours select 5, 8, 3, 4, 2017, 10
insert workhours select 5, 8, 4, 4, 2017, 9
insert workhours select 5, 8, 5, 4, 2017, 9
insert workhours select 5, 8, 6, 4, 2017, 9
insert workhours select 5, 8, 7, 4, 2017, 8
insert workhours select 5, 8, 10, 4, 2017, 8
insert workhours select 5, 8, 11, 4, 2017, 8
insert workhours select 5, 8, 12, 4, 2017, 8
insert workhours select 5, 8, 13, 4, 2017, 8
insert workhours select 5, 8, 14, 4, 2017, 8
insert workhours select 5, 8, 17, 4, 2017, 8
insert workhours select 5, 8, 18, 4, 2017, 8
insert workhours select 5, 8, 19, 4, 2017, 7
insert workhours select 5, 8, 20, 4, 2017, 10
insert workhours select 5, 8, 21, 4, 2017, 10
insert workhours select 5, 8, 24, 4, 2017, 10
insert workhours select 5, 8, 25, 4, 2017, 9
insert workhours select 5, 8, 26, 4, 2017, 8
insert workhours select 5, 8, 27, 4, 2017, 8
insert workhours select 5, 8, 28, 4, 2017, 8
insert workhours select 5, 8, 1, 5, 2017, 8
insert workhours select 5, 8, 2, 5, 2017, 8
insert workhours select 5, 8, 3, 5, 2017, 8
insert workhours select 5, 8, 4, 5, 2017, 8
insert workhours select 5, 8, 5, 5, 2017, 8
insert workhours select 5, 8, 8, 5, 2017, 8
insert workhours select 5, 8, 9, 5, 2017, 8
insert workhours select 5, 8, 10, 5, 2017, 9
insert workhours select 5, 8, 11, 5, 2017, 9
insert workhours select 5, 8, 12, 5, 2017, 9
insert workhours select 5, 8, 15, 5, 2017, 9
insert workhours select 5, 8, 16, 5, 2017, 10
insert workhours select 5, 8, 17, 5, 2017, 10
insert workhours select 5, 8, 18, 5, 2017, 10
insert workhours select 5, 8, 19, 5, 2017, 10
insert workhours select 5, 8, 22, 5, 2017, 11
insert workhours select 5, 8, 23, 5, 2017, 8
insert workhours select 5, 8, 24, 5, 2017, 8
insert workhours select 5, 8, 25, 5, 2017, 8
insert workhours select 5, 8, 26, 5, 2017, 8
insert workhours select 5, 8, 29, 5, 2017, 7
insert workhours select 5, 8, 30, 5, 2017, 5
insert workhours select 5, 8, 31, 5, 2017, 10
insert workhours select 5, 8, 1, 6, 2017, 10
insert workhours select 5, 8, 2, 6, 2017, 10
insert workhours select 5, 8, 5, 6, 2017, 8
insert workhours select 5, 8, 6, 6, 2017, 7
insert workhours select 5, 8, 7, 6, 2017, 8
insert workhours select 5, 8, 8, 6, 2017, 8
insert workhours select 5, 8, 9, 6, 2017, 9
insert workhours select 5, 8, 12, 6, 2017, 9
insert workhours select 5, 8, 13, 6, 2017, 9
insert workhours select 5, 8, 14, 6, 2017, 9
insert workhours select 5, 8, 15, 6, 2017, 9
insert workhours select 5, 8, 16, 6, 2017, 9
insert workhours select 5, 8, 19, 6, 2017, 9
insert workhours select 5, 8, 20, 6, 2017, 8
insert workhours select 5, 8, 21, 6, 2017, 10
insert workhours select 5, 8, 22, 6, 2017, 6
insert workhours select 5, 8, 23, 6, 2017, 6
insert workhours select 5, 8, 26, 6, 2017, 7
insert workhours select 5, 8, 27, 6, 2017, 8
insert workhours select 5, 8, 28, 6, 2017, 8
insert workhours select 5, 8, 29, 6, 2017, 8
insert workhours select 5, 8, 30, 6, 2017, 8
insert workhours select 5, 8, 3, 7, 2017, 8
insert workhours select 5, 8, 4, 7, 2017, 8
insert workhours select 5, 8, 5, 7, 2017, 8
insert workhours select 5, 8, 6, 7, 2017, 8
insert workhours select 5, 8, 7, 7, 2017, 7
insert workhours select 5, 8, 10, 7, 2017, 7
insert workhours select 5, 8, 11, 7, 2017, 9
insert workhours select 5, 8, 12, 7, 2017, 9
insert workhours select 5, 8, 13, 7, 2017, 9
insert workhours select 5, 8, 14, 7, 2017, 9
insert workhours select 5, 8, 17, 7, 2017, 9
insert workhours select 5, 8, 18, 7, 2017, 9
insert workhours select 5, 8, 19, 7, 2017, 10
insert workhours select 5, 8, 20, 7, 2017, 10
insert workhours select 5, 8, 21, 7, 2017, 10
insert workhours select 5, 8, 24, 7, 2017, 10
insert workhours select 5, 8, 25, 7, 2017, 10
insert workhours select 5, 8, 26, 7, 2017, 10
insert workhours select 5, 8, 27, 7, 2017, 10
insert workhours select 5, 8, 28, 7, 2017, 10
insert workhours select 5, 8, 31, 7, 2017, 9
insert workhours select 5, 8, 1, 8, 2017, 9
insert workhours select 5, 8, 2, 8, 2017, 9
insert workhours select 5, 8, 3, 8, 2017, 9
insert workhours select 5, 8, 4, 8, 2017, 9
insert workhours select 5, 8, 7, 8, 2017, 9
insert workhours select 5, 8, 8, 8, 2017, 9
insert workhours select 5, 8, 9, 8, 2017, 6
insert workhours select 5, 8, 10, 8, 2017, 7
insert workhours select 5, 8, 11, 8, 2017, 8
insert workhours select 5, 8, 14, 8, 2017, 8
insert workhours select 5, 8, 15, 8, 2017, 8
insert workhours select 5, 8, 16, 8, 2017, 8
insert workhours select 5, 8, 17, 8, 2017, 9
insert workhours select 5, 8, 18, 8, 2017, 9
insert workhours select 5, 8, 21, 8, 2017, 9
insert workhours select 5, 8, 22, 8, 2017, 10
insert workhours select 5, 8, 23, 8, 2017, 9
insert workhours select 5, 8, 24, 8, 2017, 9
insert workhours select 5, 8, 25, 8, 2017, 9
insert workhours select 5, 8, 28, 8, 2017, 8
insert workhours select 5, 8, 29, 8, 2017, 8
insert workhours select 5, 8, 30, 8, 2017, 8
insert workhours select 5, 8, 31, 8, 2017, 8
insert workhours select 5, 8, 1, 9, 2017, 8
insert workhours select 5, 8, 4, 9, 2017, 8
insert workhours select 5, 8, 5, 9, 2017, 8
insert workhours select 5, 8, 6, 9, 2017, 8
insert workhours select 5, 8, 7, 9, 2017, 8
insert workhours select 5, 8, 8, 9, 2017, 8
insert workhours select 5, 8, 11, 9, 2017, 8
insert workhours select 5, 8, 12, 9, 2017, 8
insert workhours select 5, 8, 13, 9, 2017, 8
insert workhours select 5, 8, 14, 9, 2017, 8
insert workhours select 5, 8, 15, 9, 2017, 8
insert workhours select 5, 8, 18, 9, 2017, 8
insert workhours select 5, 8, 19, 9, 2017, 8
insert workhours select 5, 8, 20, 9, 2017, 8
insert workhours select 5, 8, 21, 9, 2017, 8
insert workhours select 5, 8, 22, 9, 2017, 8
insert workhours select 5, 8, 25, 9, 2017, 8
insert workhours select 5, 8, 26, 9, 2017, 8
insert workhours select 5, 8, 27, 9, 2017, 8
insert workhours select 5, 8, 28, 9, 2017, 8
insert workhours select 5, 8, 29, 9, 2017, 8
insert workhours select 5, 4, 2, 7, 2017, 7
insert workhours select 5, 4, 3, 7, 2017, 10
insert workhours select 5, 4, 4, 7, 2017, 10
insert workhours select 5, 4, 5, 7, 2017, 10
insert workhours select 5, 4, 6, 7, 2017, 9
insert workhours select 5, 4, 7, 7, 2017, 8
insert workhours select 5, 4, 10, 7, 2017, 8
insert workhours select 5, 4, 11, 7, 2017, 8
insert workhours select 5, 4, 12, 7, 2017, 8
insert workhours select 5, 4, 13, 7, 2017, 8
insert workhours select 5, 4, 14, 7, 2017, 8
insert workhours select 5, 4, 17, 7, 2017, 8
insert workhours select 5, 4, 18, 7, 2017, 8
insert workhours select 5, 4, 19, 7, 2017, 8
insert workhours select 5, 4, 20, 7, 2017, 8
insert workhours select 5, 4, 21, 7, 2017, 9
insert workhours select 5, 4, 24, 7, 2017, 9
insert workhours select 5, 4, 25, 7, 2017, 9
insert workhours select 5, 4, 26, 7, 2017, 9
insert workhours select 5, 4, 27, 7, 2017, 10
insert workhours select 5, 4, 28, 7, 2017, 10
insert workhours select 5, 4, 31, 7, 2017, 10
insert workhours select 5, 4, 1, 8, 2017, 10
insert workhours select 5, 4, 2, 8, 2017, 11
insert workhours select 5, 4, 3, 8, 2017, 8
insert workhours select 5, 4, 4, 8, 2017, 8
insert workhours select 5, 4, 7, 8, 2017, 8
insert workhours select 5, 4, 8, 8, 2017, 8
insert workhours select 5, 4, 9, 8, 2017, 7
insert workhours select 5, 4, 10, 8, 2017, 5
insert workhours select 5, 4, 11, 8, 2017, 10
insert workhours select 5, 4, 14, 8, 2017, 10
insert workhours select 5, 4, 15, 8, 2017, 10
insert workhours select 5, 4, 16, 8, 2017, 8
insert workhours select 5, 4, 17, 8, 2017, 7
insert workhours select 5, 4, 18, 8, 2017, 8
insert workhours select 5, 4, 21, 8, 2017, 8
insert workhours select 5, 4, 22, 8, 2017, 9
insert workhours select 5, 4, 23, 8, 2017, 9
insert workhours select 5, 4, 24, 8, 2017, 9
insert workhours select 5, 4, 25, 8, 2017, 9
insert workhours select 5, 4, 28, 8, 2017, 9
insert workhours select 5, 4, 29, 8, 2017, 9
insert workhours select 5, 4, 30, 8, 2017, 9
insert workhours select 5, 4, 31, 8, 2017, 8
insert workhours select 5, 4, 1, 9, 2017, 10
insert workhours select 5, 4, 4, 9, 2017, 6
insert workhours select 5, 4, 5, 9, 2017, 6
insert workhours select 5, 4, 6, 9, 2017, 7
insert workhours select 5, 4, 7, 9, 2017, 8
insert workhours select 5, 4, 8, 9, 2017, 8
insert workhours select 5, 4, 11, 9, 2017, 8
insert workhours select 5, 4, 12, 9, 2017, 8
insert workhours select 5, 4, 13, 9, 2017, 8
insert workhours select 5, 4, 14, 9, 2017, 8
insert workhours select 5, 4, 15, 9, 2017, 8
insert workhours select 5, 4, 18, 9, 2017, 8
insert workhours select 5, 4, 19, 9, 2017, 7
insert workhours select 5, 4, 20, 9, 2017, 7
insert workhours select 5, 4, 21, 9, 2017, 9
insert workhours select 5, 4, 22, 9, 2017, 9
insert workhours select 5, 4, 25, 9, 2017, 9
insert workhours select 5, 4, 26, 9, 2017, 9
insert workhours select 5, 4, 27, 9, 2017, 9
insert workhours select 5, 4, 28, 9, 2017, 9
insert workhours select 5, 4, 29, 9, 2017, 10
insert workhours select 6, 9, 3, 2, 2017, 10
insert workhours select 6, 9, 6, 2, 2017, 10
insert workhours select 6, 9, 7, 2, 2017, 10
insert workhours select 6, 9, 8, 2, 2017, 10
insert workhours select 6, 9, 9, 2, 2017, 10
insert workhours select 6, 9, 10, 2, 2017, 10
insert workhours select 6, 9, 13, 2, 2017, 10
insert workhours select 6, 9, 14, 2, 2017, 9
insert workhours select 6, 9, 15, 2, 2017, 9
insert workhours select 6, 9, 16, 2, 2017, 9
insert workhours select 6, 9, 17, 2, 2017, 9
insert workhours select 6, 9, 20, 2, 2017, 9
insert workhours select 6, 9, 21, 2, 2017, 9
insert workhours select 6, 9, 22, 2, 2017, 9
insert workhours select 6, 9, 23, 2, 2017, 6
insert workhours select 6, 9, 24, 2, 2017, 7
insert workhours select 6, 9, 27, 2, 2017, 8
insert workhours select 6, 9, 28, 2, 2017, 8
insert workhours select 7, 5, 15, 2, 2017, 8
insert workhours select 7, 5, 16, 2, 2017, 8
insert workhours select 7, 5, 17, 2, 2017, 9
insert workhours select 7, 5, 20, 2, 2017, 8
insert workhours select 7, 5, 21, 2, 2017, 8
insert workhours select 7, 5, 22, 2, 2017, 8
insert workhours select 7, 5, 23, 2, 2017, 8
insert workhours select 7, 5, 24, 2, 2017, 8
insert workhours select 7, 5, 27, 2, 2017, 7
insert workhours select 7, 5, 28, 2, 2017, 10
insert workhours select 7, 5, 1, 3, 2017, 10
insert workhours select 7, 5, 2, 3, 2017, 10
insert workhours select 7, 5, 3, 3, 2017, 9
insert workhours select 7, 5, 6, 3, 2017, 8
insert workhours select 7, 5, 7, 3, 2017, 8
insert workhours select 7, 5, 8, 3, 2017, 8
insert workhours select 7, 5, 9, 3, 2017, 8
insert workhours select 7, 5, 10, 3, 2017, 8
insert workhours select 7, 5, 13, 3, 2017, 8
insert workhours select 7, 5, 14, 3, 2017, 8
insert workhours select 7, 5, 15, 3, 2017, 8
insert workhours select 7, 5, 16, 3, 2017, 8
insert workhours select 7, 5, 17, 3, 2017, 8
insert workhours select 7, 5, 20, 3, 2017, 9
insert workhours select 8, 3, 1, 3, 2017, 9
insert workhours select 8, 3, 2, 3, 2017, 9
insert workhours select 8, 3, 3, 3, 2017, 9
insert workhours select 8, 3, 6, 3, 2017, 10
insert workhours select 8, 3, 7, 3, 2017, 10
insert workhours select 8, 3, 8, 3, 2017, 10
insert workhours select 8, 3, 9, 3, 2017, 10
insert workhours select 8, 3, 10, 3, 2017, 11
insert workhours select 8, 3, 13, 3, 2017, 8
insert workhours select 8, 3, 14, 3, 2017, 8
insert workhours select 8, 3, 15, 3, 2017, 8
insert workhours select 8, 3, 16, 3, 2017, 8
insert workhours select 8, 3, 17, 3, 2017, 7
insert workhours select 8, 3, 20, 3, 2017, 5
insert workhours select 8, 3, 21, 3, 2017, 10
insert workhours select 8, 3, 22, 3, 2017, 10
insert workhours select 8, 3, 23, 3, 2017, 10
insert workhours select 8, 3, 24, 3, 2017, 8
insert workhours select 8, 3, 27, 3, 2017, 7
insert workhours select 8, 3, 28, 3, 2017, 8
insert workhours select 8, 3, 29, 3, 2017, 8
insert workhours select 8, 3, 30, 3, 2017, 9
insert workhours select 8, 3, 31, 3, 2017, 9
insert workhours select 8, 3, 1, 4, 2017, 9
insert workhours select 9, 9, 15, 5, 2017, 9
insert workhours select 9, 9, 16, 5, 2017, 9
insert workhours select 9, 9, 17, 5, 2017, 9
insert workhours select 9, 9, 18, 5, 2017, 9
insert workhours select 9, 9, 19, 5, 2017, 8
insert workhours select 9, 9, 22, 5, 2017, 10
insert workhours select 9, 9, 23, 5, 2017, 6
insert workhours select 9, 9, 24, 5, 2017, 6
insert workhours select 9, 9, 25, 5, 2017, 7
insert workhours select 9, 9, 26, 5, 2017, 8
insert workhours select 9, 9, 29, 5, 2017, 8
insert workhours select 9, 9, 30, 5, 2017, 8
insert workhours select 9, 9, 31, 5, 2017, 8
insert workhours select 9, 9, 1, 6, 2017, 8
insert workhours select 9, 9, 2, 6, 2017, 8
insert workhours select 9, 9, 5, 6, 2017, 8
insert workhours select 9, 9, 6, 6, 2017, 8
insert workhours select 9, 9, 7, 6, 2017, 7
insert workhours select 9, 9, 8, 6, 2017, 7
insert workhours select 9, 9, 9, 6, 2017, 9
insert workhours select 9, 9, 12, 6, 2017, 9
insert workhours select 9, 9, 13, 6, 2017, 9
insert workhours select 9, 9, 14, 6, 2017, 9
insert workhours select 9, 9, 15, 6, 2017, 9
insert workhours select 9, 9, 16, 6, 2017, 9
insert workhours select 9, 9, 19, 6, 2017, 10
insert workhours select 9, 9, 20, 6, 2017, 10
insert workhours select 9, 9, 21, 6, 2017, 10
insert workhours select 9, 9, 22, 6, 2017, 10
insert workhours select 9, 9, 23, 6, 2017, 10
insert workhours select 9, 9, 26, 6, 2017, 10
insert workhours select 9, 9, 27, 6, 2017, 10
insert workhours select 9, 9, 28, 6, 2017, 10
insert workhours select 9, 9, 29, 6, 2017, 9
insert workhours select 9, 9, 30, 6, 2017, 9
insert workhours select 9, 9, 3, 7, 2017, 9
insert workhours select 9, 9, 4, 7, 2017, 9
insert workhours select 9, 9, 5, 7, 2017, 9
insert workhours select 9, 9, 6, 7, 2017, 9
insert workhours select 9, 9, 7, 7, 2017, 9
insert workhours select 9, 9, 10, 7, 2017, 6
insert workhours select 9, 9, 11, 7, 2017, 7
insert workhours select 9, 9, 12, 7, 2017, 8
insert workhours select 9, 9, 13, 7, 2017, 8
insert workhours select 9, 9, 14, 7, 2017, 8
insert workhours select 9, 9, 17, 7, 2017, 8
insert workhours select 9, 9, 18, 7, 2017, 9
insert workhours select 9, 9, 19, 7, 2017, 9
insert workhours select 9, 9, 20, 7, 2017, 8
insert workhours select 9, 9, 21, 7, 2017, 8
insert workhours select 9, 9, 24, 7, 2017, 8
insert workhours select 9, 9, 25, 7, 2017, 8
insert workhours select 9, 9, 26, 7, 2017, 8
insert workhours select 9, 9, 27, 7, 2017, 7
insert workhours select 9, 9, 28, 7, 2017, 10
insert workhours select 9, 9, 31, 7, 2017, 10
insert workhours select 9, 9, 1, 8, 2017, 10
insert workhours select 9, 9, 2, 8, 2017, 9
insert workhours select 9, 9, 3, 8, 2017, 8
insert workhours select 9, 9, 4, 8, 2017, 8
insert workhours select 9, 9, 7, 8, 2017, 8
insert workhours select 9, 9, 8, 8, 2017, 8
insert workhours select 9, 9, 9, 8, 2017, 8
insert workhours select 9, 9, 10, 8, 2017, 8
insert workhours select 9, 9, 11, 8, 2017, 8
insert workhours select 9, 9, 14, 8, 2017, 8
insert workhours select 9, 9, 15, 8, 2017, 8
insert workhours select 9, 9, 16, 8, 2017, 8
insert workhours select 9, 9, 17, 8, 2017, 9
insert workhours select 9, 9, 18, 8, 2017, 9
insert workhours select 9, 9, 21, 8, 2017, 9
insert workhours select 9, 9, 22, 8, 2017, 9
insert workhours select 9, 9, 23, 8, 2017, 10
insert workhours select 9, 9, 24, 8, 2017, 10
insert workhours select 9, 9, 25, 8, 2017, 10
insert workhours select 9, 9, 28, 8, 2017, 10
insert workhours select 9, 9, 29, 8, 2017, 11
insert workhours select 9, 9, 30, 8, 2017, 8
insert workhours select 9, 9, 31, 8, 2017, 8
insert workhours select 9, 9, 1, 9, 2017, 8
insert workhours select 9, 9, 4, 9, 2017, 8
insert workhours select 9, 9, 5, 9, 2017, 7
insert workhours select 9, 9, 6, 9, 2017, 5
insert workhours select 9, 9, 7, 9, 2017, 10
insert workhours select 9, 9, 8, 9, 2017, 10
insert workhours select 9, 9, 11, 9, 2017, 10
insert workhours select 9, 9, 12, 9, 2017, 8
insert workhours select 9, 9, 13, 9, 2017, 7
insert workhours select 9, 9, 14, 9, 2017, 8
insert workhours select 9, 9, 15, 9, 2017, 8
insert workhours select 9, 9, 18, 9, 2017, 9
insert workhours select 9, 9, 19, 9, 2017, 9
insert workhours select 9, 9, 20, 9, 2017, 9
insert workhours select 9, 9, 21, 9, 2017, 9
insert workhours select 9, 9, 22, 9, 2017, 9
insert workhours select 9, 9, 25, 9, 2017, 9
insert workhours select 9, 9, 26, 9, 2017, 9
insert workhours select 9, 9, 27, 9, 2017, 8
insert workhours select 9, 9, 28, 9, 2017, 10
insert workhours select 9, 9, 29, 9, 2017, 6
insert workhours select 10, 10, 5, 7, 2017, 6
insert workhours select 10, 10, 6, 7, 2017, 7
insert workhours select 10, 10, 7, 7, 2017, 8
insert workhours select 10, 10, 10, 7, 2017, 8
insert workhours select 10, 10, 11, 7, 2017, 8
insert workhours select 10, 10, 12, 7, 2017, 8
insert workhours select 10, 10, 13, 7, 2017, 8
insert workhours select 10, 10, 14, 7, 2017, 8
insert workhours select 10, 10, 15, 7, 2017, 8
insert workhours select 11, 9, 20, 7, 2017, 8
insert workhours select 11, 9, 21, 7, 2017, 7
insert workhours select 11, 9, 24, 7, 2017, 7
insert workhours select 11, 9, 25, 7, 2017, 9
insert workhours select 11, 9, 26, 7, 2017, 9
insert workhours select 11, 9, 27, 7, 2017, 9
insert workhours select 11, 9, 28, 7, 2017, 9
insert workhours select 11, 9, 31, 7, 2017, 9
insert workhours select 11, 9, 1, 8, 2017, 9
insert workhours select 11, 9, 2, 8, 2017, 10
insert workhours select 11, 9, 3, 8, 2017, 10
insert workhours select 11, 9, 4, 8, 2017, 10
insert workhours select 11, 9, 7, 8, 2017, 10
insert workhours select 11, 9, 8, 8, 2017, 10
insert workhours select 11, 9, 9, 8, 2017, 10
insert workhours select 11, 9, 10, 8, 2017, 10
insert workhours select 11, 9, 11, 8, 2017, 10
insert workhours select 11, 9, 14, 8, 2017, 9
insert workhours select 11, 9, 15, 8, 2017, 9
insert workhours select 11, 9, 16, 8, 2017, 9
insert workhours select 11, 9, 17, 8, 2017, 9
insert workhours select 11, 9, 18, 8, 2017, 9
insert workhours select 11, 9, 21, 8, 2017, 9
insert workhours select 11, 9, 22, 8, 2017, 9
insert workhours select 11, 9, 23, 8, 2017, 6
insert workhours select 11, 9, 24, 8, 2017, 7
insert workhours select 11, 9, 25, 8, 2017, 8
insert workhours select 11, 9, 28, 8, 2017, 8
insert workhours select 11, 9, 29, 8, 2017, 8
insert workhours select 11, 9, 30, 8, 2017, 8
insert workhours select 11, 9, 31, 8, 2017, 9
insert workhours select 11, 9, 1, 9, 2017, 9
insert workhours select 11, 9, 4, 9, 2017, 9
insert workhours select 11, 9, 5, 9, 2017, 10
insert workhours select 11, 9, 6, 9, 2017, 9
insert workhours select 11, 9, 7, 9, 2017, 9
insert workhours select 11, 9, 8, 9, 2017, 9
insert workhours select 11, 9, 11, 9, 2017, 8
insert workhours select 11, 9, 12, 9, 2017, 8
insert workhours select 11, 9, 13, 9, 2017, 8
insert workhours select 11, 9, 14, 9, 2017, 8
insert workhours select 11, 9, 15, 9, 2017, 8
insert workhours select 11, 9, 18, 9, 2017, 8
insert workhours select 11, 9, 19, 9, 2017, 8
insert workhours select 11, 9, 20, 9, 2017, 8
insert workhours select 11, 9, 21, 9, 2017, 8
insert workhours select 11, 9, 22, 9, 2017, 8
insert workhours select 11, 9, 25, 9, 2017, 8
insert workhours select 11, 9, 26, 9, 2017, 8
insert workhours select 11, 9, 27, 9, 2017, 8
insert workhours select 11, 9, 28, 9, 2017, 8
insert workhours select 11, 9, 29, 9, 2017, 8
insert workhours select 12, 2, 1, 3, 2016, 8
insert workhours select 12, 2, 2, 3, 2016, 7
insert workhours select 12, 2, 3, 3, 2016, 10
insert workhours select 12, 2, 4, 3, 2016, 10
insert workhours select 12, 2, 7, 3, 2016, 10
insert workhours select 12, 2, 8, 3, 2016, 9
insert workhours select 12, 2, 9, 3, 2016, 8
insert workhours select 12, 2, 10, 3, 2016, 8
insert workhours select 12, 2, 11, 3, 2016, 8
insert workhours select 12, 2, 14, 3, 2016, 8
insert workhours select 12, 2, 15, 3, 2016, 8
insert workhours select 12, 2, 16, 3, 2016, 8
insert workhours select 12, 2, 17, 3, 2016, 8
insert workhours select 12, 2, 18, 3, 2016, 8
insert workhours select 12, 2, 21, 3, 2016, 8
insert workhours select 12, 2, 22, 3, 2016, 8
insert workhours select 12, 2, 23, 3, 2016, 9
insert workhours select 12, 2, 24, 3, 2016, 9
insert workhours select 12, 2, 25, 3, 2016, 9
insert workhours select 12, 2, 28, 3, 2016, 9
insert workhours select 12, 2, 29, 3, 2016, 10
insert workhours select 12, 2, 30, 3, 2016, 10
insert workhours select 12, 2, 31, 3, 2016, 10
insert workhours select 12, 2, 1, 4, 2016, 10
insert workhours select 12, 2, 4, 4, 2016, 11
insert workhours select 12, 2, 5, 4, 2016, 8
insert workhours select 12, 2, 6, 4, 2016, 8
insert workhours select 12, 2, 7, 4, 2016, 8
insert workhours select 12, 2, 8, 4, 2016, 8
insert workhours select 12, 2, 11, 4, 2016, 7
insert workhours select 12, 2, 12, 4, 2016, 5
insert workhours select 12, 2, 13, 4, 2016, 10
insert workhours select 12, 2, 14, 4, 2016, 10
insert workhours select 12, 2, 15, 4, 2016, 10
insert workhours select 12, 2, 18, 4, 2016, 8
insert workhours select 12, 2, 19, 4, 2016, 7
insert workhours select 12, 2, 20, 4, 2016, 8
insert workhours select 12, 2, 21, 4, 2016, 8
insert workhours select 12, 2, 22, 4, 2016, 9
insert workhours select 12, 2, 25, 4, 2016, 9
insert workhours select 12, 2, 26, 4, 2016, 9
insert workhours select 12, 2, 27, 4, 2016, 9
insert workhours select 12, 2, 28, 4, 2016, 9
insert workhours select 12, 2, 29, 4, 2016, 9
insert workhours select 12, 2, 2, 5, 2016, 9
insert workhours select 12, 2, 3, 5, 2016, 8
insert workhours select 12, 2, 4, 5, 2016, 10
insert workhours select 12, 2, 5, 5, 2016, 6
insert workhours select 12, 2, 6, 5, 2016, 6
insert workhours select 12, 2, 9, 5, 2016, 7
insert workhours select 12, 2, 10, 5, 2016, 8
insert workhours select 12, 2, 11, 5, 2016, 8
insert workhours select 12, 2, 12, 5, 2016, 8
insert workhours select 12, 2, 13, 5, 2016, 8
insert workhours select 12, 2, 16, 5, 2016, 8
insert workhours select 12, 2, 17, 5, 2016, 8
insert workhours select 12, 2, 18, 5, 2016, 8
insert workhours select 12, 2, 19, 5, 2016, 8
insert workhours select 12, 2, 20, 5, 2016, 7
insert workhours select 12, 2, 23, 5, 2016, 7
insert workhours select 12, 2, 24, 5, 2016, 9
insert workhours select 12, 2, 25, 5, 2016, 9
insert workhours select 12, 2, 26, 5, 2016, 9
insert workhours select 12, 2, 27, 5, 2016, 9
insert workhours select 12, 2, 30, 5, 2016, 9
insert workhours select 12, 2, 31, 5, 2016, 9
insert workhours select 12, 2, 1, 6, 2016, 10
insert workhours select 12, 2, 2, 6, 2016, 10
insert workhours select 12, 2, 3, 6, 2016, 10
insert workhours select 12, 2, 6, 6, 2016, 10
insert workhours select 12, 2, 7, 6, 2016, 10
insert workhours select 12, 2, 8, 6, 2016, 10
insert workhours select 12, 2, 9, 6, 2016, 10
insert workhours select 12, 2, 10, 6, 2016, 10
insert workhours select 12, 2, 13, 6, 2016, 9
insert workhours select 12, 2, 14, 6, 2016, 9
insert workhours select 12, 2, 15, 6, 2016, 9
insert workhours select 12, 2, 16, 6, 2016, 9
insert workhours select 12, 2, 17, 6, 2016, 9
insert workhours select 12, 2, 20, 6, 2016, 9
insert workhours select 12, 2, 21, 6, 2016, 9
insert workhours select 12, 2, 22, 6, 2016, 6
insert workhours select 12, 2, 23, 6, 2016, 7
insert workhours select 12, 2, 24, 6, 2016, 8
insert workhours select 12, 2, 27, 6, 2016, 8
insert workhours select 12, 2, 28, 6, 2016, 8
insert workhours select 12, 2, 29, 6, 2016, 8
insert workhours select 12, 2, 30, 6, 2016, 9
insert workhours select 12, 2, 1, 7, 2016, 9
insert workhours select 12, 2, 4, 7, 2016, 9
insert workhours select 12, 2, 5, 7, 2016, 10
insert workhours select 12, 2, 6, 7, 2016, 9
insert workhours select 12, 2, 7, 7, 2016, 9
insert workhours select 12, 2, 8, 7, 2016, 9
insert workhours select 12, 2, 11, 7, 2016, 8
insert workhours select 12, 2, 12, 7, 2016, 8
insert workhours select 12, 2, 13, 7, 2016, 8
insert workhours select 12, 2, 14, 7, 2016, 8
insert workhours select 12, 2, 15, 7, 2016, 8
insert workhours select 12, 2, 18, 7, 2016, 8
insert workhours select 12, 2, 19, 7, 2016, 8
insert workhours select 12, 2, 20, 7, 2016, 8
insert workhours select 12, 2, 21, 7, 2016, 8
insert workhours select 12, 2, 22, 7, 2016, 8
insert workhours select 12, 2, 25, 7, 2016, 7
insert workhours select 12, 2, 26, 7, 2016, 10
insert workhours select 12, 2, 27, 7, 2016, 10
insert workhours select 12, 2, 28, 7, 2016, 10
insert workhours select 12, 2, 29, 7, 2016, 9
insert workhours select 12, 2, 1, 8, 2016, 8
insert workhours select 12, 2, 2, 8, 2016, 8
insert workhours select 12, 2, 3, 8, 2016, 8
insert workhours select 12, 2, 4, 8, 2016, 8
insert workhours select 12, 2, 5, 8, 2016, 8
insert workhours select 12, 2, 8, 8, 2016, 8
insert workhours select 12, 2, 9, 8, 2016, 8
insert workhours select 12, 2, 10, 8, 2016, 8
insert workhours select 12, 2, 11, 8, 2016, 8
insert workhours select 12, 2, 12, 8, 2016, 8
insert workhours select 12, 2, 15, 8, 2016, 9
insert workhours select 12, 2, 16, 8, 2016, 9
insert workhours select 12, 2, 17, 8, 2016, 9
insert workhours select 12, 2, 18, 8, 2016, 9
insert workhours select 12, 2, 19, 8, 2016, 10
insert workhours select 12, 2, 22, 8, 2016, 10
insert workhours select 12, 2, 23, 8, 2016, 10
insert workhours select 12, 2, 24, 8, 2016, 10
insert workhours select 12, 2, 25, 8, 2016, 11
insert workhours select 12, 2, 26, 8, 2016, 8
insert workhours select 12, 2, 29, 8, 2016, 8
insert workhours select 12, 2, 30, 8, 2016, 8
insert workhours select 12, 2, 31, 8, 2016, 8
insert workhours select 12, 2, 1, 9, 2016, 7
insert workhours select 12, 2, 2, 9, 2016, 5
insert workhours select 12, 2, 5, 9, 2016, 10
insert workhours select 12, 2, 6, 9, 2016, 10
insert workhours select 12, 2, 7, 9, 2016, 10
insert workhours select 12, 2, 8, 9, 2016, 8
insert workhours select 12, 2, 9, 9, 2016, 7
insert workhours select 12, 2, 12, 9, 2016, 8
insert workhours select 12, 2, 13, 9, 2016, 8
insert workhours select 12, 2, 14, 9, 2016, 9
insert workhours select 12, 2, 15, 9, 2016, 9
insert workhours select 12, 2, 16, 9, 2016, 9
insert workhours select 12, 2, 19, 9, 2016, 9
insert workhours select 12, 2, 20, 9, 2016, 9
insert workhours select 12, 2, 21, 9, 2016, 9
insert workhours select 12, 2, 22, 9, 2016, 9
insert workhours select 12, 2, 23, 9, 2016, 8
insert workhours select 12, 2, 26, 9, 2016, 10
insert workhours select 12, 2, 27, 9, 2016, 6
insert workhours select 12, 2, 28, 9, 2016, 6
insert workhours select 12, 2, 29, 9, 2016, 7
insert workhours select 12, 2, 30, 9, 2016, 8
insert workhours select 12, 2, 3, 10, 2016, 8
insert workhours select 12, 2, 4, 10, 2016, 8
insert workhours select 12, 2, 5, 10, 2016, 8
insert workhours select 12, 2, 6, 10, 2016, 8
insert workhours select 12, 2, 7, 10, 2016, 8
insert workhours select 12, 2, 10, 10, 2016, 8
insert workhours select 12, 2, 11, 10, 2016, 8
insert workhours select 12, 2, 12, 10, 2016, 7
insert workhours select 12, 2, 13, 10, 2016, 7
insert workhours select 12, 2, 14, 10, 2016, 9
insert workhours select 12, 2, 17, 10, 2016, 9
insert workhours select 12, 2, 18, 10, 2016, 9
insert workhours select 12, 2, 19, 10, 2016, 9
insert workhours select 12, 2, 20, 10, 2016, 9
insert workhours select 12, 2, 21, 10, 2016, 9
insert workhours select 12, 2, 24, 10, 2016, 10
insert workhours select 12, 2, 25, 10, 2016, 10
insert workhours select 12, 2, 26, 10, 2016, 10
insert workhours select 12, 2, 27, 10, 2016, 10
insert workhours select 12, 2, 28, 10, 2016, 10
insert workhours select 12, 2, 31, 10, 2016, 10
insert workhours select 12, 2, 1, 11, 2016, 10
insert workhours select 12, 2, 2, 11, 2016, 10
insert workhours select 12, 2, 3, 11, 2016, 9
insert workhours select 12, 2, 4, 11, 2016, 9
insert workhours select 12, 2, 7, 11, 2016, 9
insert workhours select 12, 2, 8, 11, 2016, 9
insert workhours select 12, 2, 9, 11, 2016, 9
insert workhours select 12, 2, 10, 11, 2016, 9
insert workhours select 12, 2, 11, 11, 2016, 9
insert workhours select 12, 2, 14, 11, 2016, 6
insert workhours select 12, 2, 15, 11, 2016, 7
insert workhours select 12, 2, 16, 11, 2016, 8
insert workhours select 12, 2, 17, 11, 2016, 8
insert workhours select 12, 2, 18, 11, 2016, 8
insert workhours select 12, 2, 21, 11, 2016, 8
insert workhours select 12, 2, 22, 11, 2016, 9
insert workhours select 12, 2, 23, 11, 2016, 9
insert workhours select 12, 2, 24, 11, 2016, 9
insert workhours select 12, 2, 25, 11, 2016, 10
insert workhours select 12, 2, 28, 11, 2016, 9
insert workhours select 12, 2, 29, 11, 2016, 8
insert workhours select 12, 2, 30, 11, 2016, 8
insert workhours select 12, 2, 1, 12, 2016, 8
insert workhours select 12, 2, 2, 12, 2016, 8
insert workhours select 12, 2, 5, 12, 2016, 8
insert workhours select 12, 2, 6, 12, 2016, 7
insert workhours select 12, 2, 7, 12, 2016, 10
insert workhours select 12, 2, 8, 12, 2016, 10
insert workhours select 12, 2, 9, 12, 2016, 10
insert workhours select 12, 2, 12, 12, 2016, 9
insert workhours select 12, 2, 13, 12, 2016, 8
insert workhours select 12, 2, 14, 12, 2016, 8
insert workhours select 12, 2, 15, 12, 2016, 8
insert workhours select 12, 2, 16, 12, 2016, 8
insert workhours select 12, 2, 19, 12, 2016, 8
insert workhours select 12, 2, 20, 12, 2016, 8
insert workhours select 12, 2, 21, 12, 2016, 8
insert workhours select 12, 2, 22, 12, 2016, 8
insert workhours select 12, 2, 23, 12, 2016, 8
insert workhours select 12, 2, 26, 12, 2016, 8
insert workhours select 12, 2, 27, 12, 2016, 9
insert workhours select 12, 2, 28, 12, 2016, 9
insert workhours select 12, 2, 29, 12, 2016, 9
insert workhours select 12, 2, 30, 12, 2016, 9
insert workhours select 12, 2, 2, 1, 2017, 10
insert workhours select 12, 2, 3, 1, 2017, 10
insert workhours select 12, 2, 4, 1, 2017, 10
insert workhours select 12, 2, 5, 1, 2017, 10
insert workhours select 12, 2, 6, 1, 2017, 11
insert workhours select 12, 2, 9, 1, 2017, 8
insert workhours select 12, 2, 10, 1, 2017, 8
insert workhours select 12, 2, 11, 1, 2017, 8
insert workhours select 12, 2, 12, 1, 2017, 8
insert workhours select 12, 2, 13, 1, 2017, 7
insert workhours select 12, 2, 16, 1, 2017, 5
insert workhours select 12, 2, 17, 1, 2017, 10
insert workhours select 12, 2, 18, 1, 2017, 10
insert workhours select 12, 2, 19, 1, 2017, 10
insert workhours select 12, 2, 20, 1, 2017, 8
insert workhours select 12, 2, 23, 1, 2017, 7
insert workhours select 12, 2, 24, 1, 2017, 8
insert workhours select 12, 2, 25, 1, 2017, 8
insert workhours select 12, 2, 26, 1, 2017, 9
insert workhours select 12, 2, 27, 1, 2017, 9
insert workhours select 12, 2, 30, 1, 2017, 9
insert workhours select 12, 2, 31, 1, 2017, 9
insert workhours select 12, 2, 1, 2, 2017, 9
insert workhours select 12, 2, 2, 2, 2017, 9
insert workhours select 12, 2, 3, 2, 2017, 9
insert workhours select 12, 2, 6, 2, 2017, 8
insert workhours select 12, 2, 7, 2, 2017, 10
insert workhours select 12, 2, 8, 2, 2017, 6
insert workhours select 12, 2, 9, 2, 2017, 6
insert workhours select 12, 2, 10, 2, 2017, 7
insert workhours select 12, 2, 13, 2, 2017, 8
insert workhours select 12, 2, 14, 2, 2017, 8
insert workhours select 12, 2, 15, 2, 2017, 8
insert workhours select 12, 2, 16, 2, 2017, 8
insert workhours select 12, 2, 17, 2, 2017, 8
insert workhours select 12, 2, 20, 2, 2017, 8
insert workhours select 12, 2, 21, 2, 2017, 8
insert workhours select 12, 2, 22, 2, 2017, 8
insert workhours select 12, 2, 23, 2, 2017, 7
insert workhours select 12, 2, 24, 2, 2017, 7
insert workhours select 12, 2, 27, 2, 2017, 9
insert workhours select 12, 2, 28, 2, 2017, 9
insert workhours select 12, 2, 1, 3, 2017, 9
insert workhours select 12, 2, 2, 3, 2017, 9
insert workhours select 12, 2, 3, 3, 2017, 9
insert workhours select 12, 2, 6, 3, 2017, 9
insert workhours select 12, 2, 7, 3, 2017, 10
insert workhours select 12, 2, 8, 3, 2017, 10
insert workhours select 12, 2, 9, 3, 2017, 10
insert workhours select 12, 2, 10, 3, 2017, 10
insert workhours select 12, 2, 13, 3, 2017, 10
insert workhours select 12, 2, 14, 3, 2017, 10
insert workhours select 12, 2, 15, 3, 2017, 10
insert workhours select 12, 2, 16, 3, 2017, 10
insert workhours select 12, 2, 17, 3, 2017, 9
insert workhours select 12, 2, 20, 3, 2017, 9
insert workhours select 12, 2, 21, 3, 2017, 9
insert workhours select 12, 2, 22, 3, 2017, 9
insert workhours select 12, 2, 23, 3, 2017, 9
insert workhours select 12, 2, 24, 3, 2017, 9
insert workhours select 12, 2, 27, 3, 2017, 9
insert workhours select 12, 2, 28, 3, 2017, 6
insert workhours select 12, 2, 29, 3, 2017, 7
insert workhours select 12, 2, 30, 3, 2017, 8
insert workhours select 12, 2, 31, 3, 2017, 8
insert workhours select 12, 2, 3, 4, 2017, 8
insert workhours select 12, 2, 4, 4, 2017, 8
insert workhours select 12, 2, 5, 4, 2017, 9
insert workhours select 12, 2, 6, 4, 2017, 9
insert workhours select 12, 2, 7, 4, 2017, 9
insert workhours select 12, 2, 10, 4, 2017, 10
insert workhours select 12, 2, 11, 4, 2017, 8
insert workhours select 12, 2, 12, 4, 2017, 8
insert workhours select 12, 2, 13, 4, 2017, 8
insert workhours select 12, 2, 14, 4, 2017, 8
insert workhours select 12, 2, 17, 4, 2017, 8
insert workhours select 12, 2, 18, 4, 2017, 7
insert workhours select 12, 2, 19, 4, 2017, 10
insert workhours select 12, 2, 20, 4, 2017, 10
insert workhours select 12, 2, 21, 4, 2017, 10
insert workhours select 12, 2, 24, 4, 2017, 9
insert workhours select 12, 2, 25, 4, 2017, 8
insert workhours select 12, 2, 26, 4, 2017, 8
insert workhours select 12, 2, 27, 4, 2017, 8
insert workhours select 12, 2, 28, 4, 2017, 8
insert workhours select 12, 2, 1, 5, 2017, 8
insert workhours select 12, 2, 2, 5, 2017, 8
insert workhours select 12, 2, 3, 5, 2017, 8
insert workhours select 12, 2, 4, 5, 2017, 8
insert workhours select 12, 2, 5, 5, 2017, 8
insert workhours select 12, 2, 8, 5, 2017, 8
insert workhours select 12, 2, 9, 5, 2017, 9
insert workhours select 12, 2, 10, 5, 2017, 9
insert workhours select 12, 2, 11, 5, 2017, 9
insert workhours select 12, 2, 12, 5, 2017, 9
insert workhours select 12, 2, 15, 5, 2017, 10
insert workhours select 12, 2, 16, 5, 2017, 10
insert workhours select 12, 2, 17, 5, 2017, 10
insert workhours select 12, 2, 18, 5, 2017, 10
insert workhours select 12, 2, 19, 5, 2017, 11
insert workhours select 12, 2, 22, 5, 2017, 8
insert workhours select 12, 2, 23, 5, 2017, 8
insert workhours select 12, 2, 24, 5, 2017, 8
insert workhours select 12, 2, 25, 5, 2017, 8
insert workhours select 12, 2, 26, 5, 2017, 7
insert workhours select 12, 2, 29, 5, 2017, 5
insert workhours select 12, 2, 30, 5, 2017, 10
insert workhours select 12, 2, 31, 5, 2017, 10
insert workhours select 12, 2, 1, 6, 2017, 10
insert workhours select 12, 2, 2, 6, 2017, 8
insert workhours select 12, 2, 5, 6, 2017, 7
insert workhours select 12, 2, 6, 6, 2017, 8
insert workhours select 12, 2, 7, 6, 2017, 8
insert workhours select 12, 2, 8, 6, 2017, 9
insert workhours select 12, 2, 9, 6, 2017, 9
insert workhours select 12, 2, 12, 6, 2017, 9
insert workhours select 12, 2, 13, 6, 2017, 9
insert workhours select 12, 2, 14, 6, 2017, 9
insert workhours select 12, 2, 15, 6, 2017, 9
insert workhours select 12, 2, 16, 6, 2017, 9
insert workhours select 12, 2, 19, 6, 2017, 8
insert workhours select 12, 2, 20, 6, 2017, 10
insert workhours select 12, 2, 21, 6, 2017, 6
insert workhours select 12, 2, 22, 6, 2017, 6
insert workhours select 12, 2, 23, 6, 2017, 7
insert workhours select 12, 2, 26, 6, 2017, 8
insert workhours select 12, 2, 27, 6, 2017, 8
insert workhours select 12, 2, 28, 6, 2017, 8
insert workhours select 12, 2, 29, 6, 2017, 8
insert workhours select 12, 2, 30, 6, 2017, 8
insert workhours select 12, 2, 3, 7, 2017, 8
insert workhours select 12, 2, 4, 7, 2017, 8
insert workhours select 12, 2, 5, 7, 2017, 8
insert workhours select 12, 2, 6, 7, 2017, 7
insert workhours select 12, 2, 7, 7, 2017, 7
insert workhours select 12, 2, 10, 7, 2017, 9
insert workhours select 12, 2, 11, 7, 2017, 9
insert workhours select 12, 2, 12, 7, 2017, 9
insert workhours select 12, 2, 13, 7, 2017, 9
insert workhours select 12, 2, 14, 7, 2017, 9
insert workhours select 12, 2, 17, 7, 2017, 9
insert workhours select 12, 2, 18, 7, 2017, 10
insert workhours select 12, 2, 19, 7, 2017, 10
insert workhours select 12, 2, 20, 7, 2017, 10
insert workhours select 12, 2, 21, 7, 2017, 10
insert workhours select 12, 2, 24, 7, 2017, 10
insert workhours select 12, 2, 25, 7, 2017, 10
insert workhours select 12, 2, 26, 7, 2017, 10
insert workhours select 12, 2, 27, 7, 2017, 10
insert workhours select 12, 2, 28, 7, 2017, 9
insert workhours select 12, 2, 31, 7, 2017, 9
insert workhours select 12, 2, 1, 8, 2017, 9
insert workhours select 12, 2, 2, 8, 2017, 9
insert workhours select 12, 2, 3, 8, 2017, 9
insert workhours select 12, 2, 4, 8, 2017, 9
insert workhours select 12, 2, 7, 8, 2017, 9
insert workhours select 12, 2, 8, 8, 2017, 6
insert workhours select 12, 2, 9, 8, 2017, 7
insert workhours select 12, 2, 10, 8, 2017, 8
insert workhours select 12, 2, 11, 8, 2017, 8
insert workhours select 12, 2, 14, 8, 2017, 8
insert workhours select 12, 2, 15, 8, 2017, 8
insert workhours select 12, 2, 16, 8, 2017, 9
insert workhours select 12, 2, 17, 8, 2017, 9
insert workhours select 12, 2, 18, 8, 2017, 9
insert workhours select 12, 2, 21, 8, 2017, 10
insert workhours select 12, 2, 22, 8, 2017, 9
insert workhours select 12, 2, 23, 8, 2017, 9
insert workhours select 12, 2, 24, 8, 2017, 9
insert workhours select 12, 2, 25, 8, 2017, 8
insert workhours select 12, 2, 28, 8, 2017, 8
insert workhours select 12, 2, 29, 8, 2017, 8
insert workhours select 12, 2, 30, 8, 2017, 8
insert workhours select 12, 2, 31, 8, 2017, 8
insert workhours select 12, 2, 1, 9, 2017, 8
insert workhours select 12, 2, 4, 9, 2017, 8
insert workhours select 12, 2, 5, 9, 2017, 8
insert workhours select 12, 2, 6, 9, 2017, 8
insert workhours select 12, 2, 7, 9, 2017, 8
insert workhours select 12, 2, 8, 9, 2017, 8
insert workhours select 12, 2, 11, 9, 2017, 8
insert workhours select 12, 2, 12, 9, 2017, 7
insert workhours select 12, 2, 13, 9, 2017, 10
insert workhours select 12, 2, 14, 9, 2017, 10
insert workhours select 12, 2, 15, 9, 2017, 10
insert workhours select 12, 2, 18, 9, 2017, 9
insert workhours select 12, 2, 19, 9, 2017, 8
insert workhours select 12, 2, 20, 9, 2017, 8
insert workhours select 12, 2, 21, 9, 2017, 8
insert workhours select 12, 2, 22, 9, 2017, 8
insert workhours select 12, 2, 25, 9, 2017, 8
insert workhours select 12, 2, 26, 9, 2017, 8
insert workhours select 12, 2, 27, 9, 2017, 8
insert workhours select 12, 2, 28, 9, 2017, 8
insert workhours select 12, 2, 29, 9, 2017, 8
insert workhours select 15, 6, 30, 12, 2015, 8
insert workhours select 15, 6, 31, 12, 2015, 9
insert workhours select 15, 6, 1, 1, 2016, 9
insert workhours select 15, 6, 4, 1, 2016, 9
insert workhours select 15, 6, 5, 1, 2016, 9
insert workhours select 15, 6, 6, 1, 2016, 10
insert workhours select 15, 6, 7, 1, 2016, 10
insert workhours select 15, 6, 8, 1, 2016, 10
insert workhours select 15, 6, 11, 1, 2016, 10
insert workhours select 15, 6, 12, 1, 2016, 11
insert workhours select 15, 6, 13, 1, 2016, 8
insert workhours select 15, 6, 14, 1, 2016, 8
insert workhours select 15, 6, 15, 1, 2016, 8
insert workhours select 15, 6, 18, 1, 2016, 8
insert workhours select 15, 6, 19, 1, 2016, 7
insert workhours select 15, 6, 20, 1, 2016, 5
insert workhours select 15, 6, 21, 1, 2016, 10
insert workhours select 15, 6, 22, 1, 2016, 10
insert workhours select 15, 6, 25, 1, 2016, 10
insert workhours select 15, 6, 26, 1, 2016, 8
insert workhours select 15, 6, 27, 1, 2016, 7
insert workhours select 15, 6, 28, 1, 2016, 8
insert workhours select 15, 6, 29, 1, 2016, 8
insert workhours select 15, 6, 1, 2, 2016, 9
insert workhours select 15, 6, 2, 2, 2016, 9
insert workhours select 15, 6, 3, 2, 2016, 9
insert workhours select 15, 6, 4, 2, 2016, 9
insert workhours select 15, 6, 5, 2, 2016, 9
insert workhours select 15, 6, 8, 2, 2016, 9
insert workhours select 15, 6, 9, 2, 2016, 9
insert workhours select 15, 6, 10, 2, 2016, 8
insert workhours select 15, 6, 11, 2, 2016, 10
insert workhours select 15, 6, 12, 2, 2016, 6
insert workhours select 15, 6, 15, 2, 2016, 6
insert workhours select 15, 6, 16, 2, 2016, 7
insert workhours select 15, 6, 17, 2, 2016, 8
insert workhours select 15, 6, 18, 2, 2016, 8
insert workhours select 15, 6, 19, 2, 2016, 8
insert workhours select 15, 6, 22, 2, 2016, 8
insert workhours select 15, 6, 23, 2, 2016, 8
insert workhours select 15, 6, 24, 2, 2016, 8
insert workhours select 15, 6, 25, 2, 2016, 8
insert workhours select 15, 6, 26, 2, 2016, 8
insert workhours select 15, 6, 29, 2, 2016, 7
insert workhours select 15, 6, 1, 3, 2016, 7
insert workhours select 15, 6, 2, 3, 2016, 9
insert workhours select 15, 6, 3, 3, 2016, 9
insert workhours select 15, 6, 4, 3, 2016, 9
insert workhours select 15, 6, 7, 3, 2016, 9
insert workhours select 15, 6, 8, 3, 2016, 9
insert workhours select 15, 6, 9, 3, 2016, 9
insert workhours select 15, 6, 10, 3, 2016, 10
insert workhours select 15, 6, 11, 3, 2016, 10
insert workhours select 15, 6, 14, 3, 2016, 10
insert workhours select 15, 6, 15, 3, 2016, 10
insert workhours select 15, 6, 16, 3, 2016, 10
insert workhours select 15, 6, 17, 3, 2016, 10
insert workhours select 15, 6, 18, 3, 2016, 10
insert workhours select 15, 6, 21, 3, 2016, 10
insert workhours select 15, 6, 22, 3, 2016, 9
insert workhours select 15, 6, 23, 3, 2016, 9
insert workhours select 15, 6, 24, 3, 2016, 9
insert workhours select 15, 6, 25, 3, 2016, 9
insert workhours select 15, 6, 28, 3, 2016, 9
insert workhours select 15, 6, 29, 3, 2016, 9
insert workhours select 15, 6, 30, 3, 2016, 9
insert workhours select 15, 6, 31, 3, 2016, 6
insert workhours select 15, 6, 1, 4, 2016, 7
insert workhours select 15, 6, 4, 4, 2016, 8
insert workhours select 15, 6, 5, 4, 2016, 8
insert workhours select 15, 6, 6, 4, 2016, 8
insert workhours select 15, 6, 7, 4, 2016, 8
insert workhours select 15, 6, 8, 4, 2016, 9
insert workhours select 15, 6, 11, 4, 2016, 9
insert workhours select 15, 6, 12, 4, 2016, 9
insert workhours select 15, 6, 13, 4, 2016, 10
insert workhours select 15, 6, 14, 4, 2016, 9
insert workhours select 15, 6, 15, 4, 2016, 9
insert workhours select 15, 6, 18, 4, 2016, 9
insert workhours select 15, 6, 19, 4, 2016, 8
insert workhours select 15, 6, 20, 4, 2016, 8
insert workhours select 15, 6, 21, 4, 2016, 8
insert workhours select 15, 6, 22, 4, 2016, 8
insert workhours select 15, 6, 25, 4, 2016, 8
insert workhours select 15, 6, 26, 4, 2016, 8
insert workhours select 15, 6, 27, 4, 2016, 8
insert workhours select 15, 6, 28, 4, 2016, 8
insert workhours select 15, 6, 29, 4, 2016, 8
insert workhours select 15, 6, 2, 5, 2016, 7
insert workhours select 15, 6, 3, 5, 2016, 10
insert workhours select 15, 6, 4, 5, 2016, 10
insert workhours select 15, 6, 5, 5, 2016, 10
insert workhours select 15, 6, 6, 5, 2016, 9
insert workhours select 15, 6, 9, 5, 2016, 8
insert workhours select 15, 6, 10, 5, 2016, 8
insert workhours select 15, 6, 11, 5, 2016, 8
insert workhours select 15, 6, 12, 5, 2016, 8
insert workhours select 15, 6, 13, 5, 2016, 8
insert workhours select 15, 6, 16, 5, 2016, 8
insert workhours select 15, 6, 17, 5, 2016, 8
insert workhours select 15, 6, 18, 5, 2016, 8
insert workhours select 15, 6, 19, 5, 2016, 8
insert workhours select 15, 6, 20, 5, 2016, 8
insert workhours select 15, 6, 23, 5, 2016, 9
insert workhours select 15, 6, 24, 5, 2016, 9
insert workhours select 15, 6, 25, 5, 2016, 9
insert workhours select 15, 6, 26, 5, 2016, 9
insert workhours select 15, 6, 27, 5, 2016, 10
insert workhours select 15, 6, 30, 5, 2016, 10
insert workhours select 15, 6, 31, 5, 2016, 10
insert workhours select 15, 6, 1, 6, 2016, 10
insert workhours select 15, 6, 2, 6, 2016, 11
insert workhours select 15, 6, 3, 6, 2016, 8
insert workhours select 15, 6, 6, 6, 2016, 8
insert workhours select 15, 6, 7, 6, 2016, 8
insert workhours select 15, 6, 8, 6, 2016, 8
insert workhours select 15, 6, 9, 6, 2016, 7
insert workhours select 15, 6, 10, 6, 2016, 5
insert workhours select 15, 6, 13, 6, 2016, 10
insert workhours select 15, 6, 14, 6, 2016, 10
insert workhours select 15, 6, 15, 6, 2016, 10
insert workhours select 15, 6, 16, 6, 2016, 8
insert workhours select 15, 6, 17, 6, 2016, 7
insert workhours select 15, 6, 20, 6, 2016, 8
insert workhours select 15, 6, 21, 6, 2016, 8
insert workhours select 15, 6, 22, 6, 2016, 9
insert workhours select 15, 6, 23, 6, 2016, 9
insert workhours select 15, 6, 24, 6, 2016, 9
insert workhours select 15, 6, 27, 6, 2016, 9
insert workhours select 15, 6, 28, 6, 2016, 9
insert workhours select 15, 6, 29, 6, 2016, 9
insert workhours select 15, 6, 30, 6, 2016, 9
insert workhours select 15, 6, 1, 7, 2016, 8
insert workhours select 15, 6, 4, 7, 2016, 10
insert workhours select 15, 6, 5, 7, 2016, 6
insert workhours select 15, 6, 6, 7, 2016, 6
insert workhours select 15, 6, 7, 7, 2016, 7
insert workhours select 15, 6, 8, 7, 2016, 8
insert workhours select 15, 6, 11, 7, 2016, 8
insert workhours select 15, 6, 12, 7, 2016, 8
insert workhours select 15, 6, 13, 7, 2016, 8
insert workhours select 15, 6, 14, 7, 2016, 8
insert workhours select 15, 6, 15, 7, 2016, 8
insert workhours select 15, 6, 18, 7, 2016, 8
insert workhours select 15, 6, 19, 7, 2016, 8
insert workhours select 15, 6, 20, 7, 2016, 7
insert workhours select 15, 6, 21, 7, 2016, 7
insert workhours select 15, 6, 22, 7, 2016, 9
insert workhours select 15, 6, 25, 7, 2016, 9
insert workhours select 15, 6, 26, 7, 2016, 9
insert workhours select 15, 6, 27, 7, 2016, 9
insert workhours select 15, 6, 28, 7, 2016, 9
insert workhours select 15, 6, 29, 7, 2016, 9
insert workhours select 15, 6, 1, 8, 2016, 10
insert workhours select 15, 6, 2, 8, 2016, 10
insert workhours select 15, 6, 3, 8, 2016, 10
insert workhours select 15, 6, 4, 8, 2016, 10
insert workhours select 15, 6, 5, 8, 2016, 10
insert workhours select 15, 6, 8, 8, 2016, 10
insert workhours select 15, 6, 9, 8, 2016, 10
insert workhours select 15, 6, 10, 8, 2016, 10
insert workhours select 15, 6, 11, 8, 2016, 9
insert workhours select 15, 6, 12, 8, 2016, 9
insert workhours select 15, 6, 15, 8, 2016, 9
insert workhours select 15, 6, 16, 8, 2016, 9
insert workhours select 15, 6, 17, 8, 2016, 9
insert workhours select 15, 6, 18, 8, 2016, 9
insert workhours select 15, 6, 19, 8, 2016, 9
insert workhours select 15, 6, 22, 8, 2016, 6
insert workhours select 15, 6, 23, 8, 2016, 7
insert workhours select 15, 6, 24, 8, 2016, 8
insert workhours select 15, 6, 25, 8, 2016, 8
insert workhours select 15, 6, 26, 8, 2016, 8
insert workhours select 15, 6, 29, 8, 2016, 8
insert workhours select 15, 6, 30, 8, 2016, 9
insert workhours select 15, 6, 31, 8, 2016, 9
insert workhours select 15, 6, 1, 9, 2016, 9
insert workhours select 15, 6, 2, 9, 2016, 10
insert workhours select 15, 6, 5, 9, 2016, 9
insert workhours select 15, 6, 6, 9, 2016, 9
insert workhours select 15, 6, 7, 9, 2016, 9
insert workhours select 15, 6, 8, 9, 2016, 8
insert workhours select 15, 6, 9, 9, 2016, 8
insert workhours select 15, 6, 12, 9, 2016, 8
insert workhours select 15, 6, 13, 9, 2016, 8
insert workhours select 15, 6, 14, 9, 2016, 8
insert workhours select 15, 6, 15, 9, 2016, 8
insert workhours select 15, 6, 16, 9, 2016, 8
insert workhours select 15, 6, 19, 9, 2016, 8
insert workhours select 15, 6, 20, 9, 2016, 7
insert workhours select 15, 6, 21, 9, 2016, 10
insert workhours select 15, 6, 22, 9, 2016, 10
insert workhours select 15, 6, 23, 9, 2016, 10
insert workhours select 15, 6, 26, 9, 2016, 9
insert workhours select 15, 6, 27, 9, 2016, 8
insert workhours select 15, 6, 28, 9, 2016, 8
insert workhours select 15, 6, 29, 9, 2016, 8
insert workhours select 15, 6, 30, 9, 2016, 8
insert workhours select 15, 6, 3, 10, 2016, 8
insert workhours select 15, 6, 4, 10, 2016, 8
insert workhours select 15, 6, 5, 10, 2016, 8
insert workhours select 15, 6, 6, 10, 2016, 8
insert workhours select 15, 6, 7, 10, 2016, 8
insert workhours select 15, 6, 10, 10, 2016, 8
insert workhours select 15, 6, 11, 10, 2016, 9
insert workhours select 15, 6, 12, 10, 2016, 9
insert workhours select 15, 6, 13, 10, 2016, 9
insert workhours select 15, 6, 14, 10, 2016, 9
insert workhours select 15, 6, 17, 10, 2016, 10
insert workhours select 15, 6, 18, 10, 2016, 10
insert workhours select 15, 6, 19, 10, 2016, 10
insert workhours select 15, 6, 20, 10, 2016, 10
insert workhours select 15, 6, 21, 10, 2016, 11
insert workhours select 15, 6, 24, 10, 2016, 8
insert workhours select 15, 6, 25, 10, 2016, 8
insert workhours select 15, 6, 26, 10, 2016, 8
insert workhours select 15, 6, 27, 10, 2016, 8
insert workhours select 15, 6, 28, 10, 2016, 7
insert workhours select 15, 6, 31, 10, 2016, 5
insert workhours select 15, 6, 1, 11, 2016, 10
insert workhours select 15, 6, 2, 11, 2016, 10
insert workhours select 15, 6, 3, 11, 2016, 10
insert workhours select 15, 6, 4, 11, 2016, 8
insert workhours select 15, 6, 7, 11, 2016, 7
insert workhours select 15, 6, 8, 11, 2016, 8
insert workhours select 15, 6, 9, 11, 2016, 8
insert workhours select 15, 6, 10, 11, 2016, 9
insert workhours select 15, 6, 11, 11, 2016, 9
insert workhours select 15, 6, 14, 11, 2016, 9
insert workhours select 15, 6, 15, 11, 2016, 9
insert workhours select 15, 6, 16, 11, 2016, 9
insert workhours select 15, 6, 17, 11, 2016, 9
insert workhours select 15, 6, 18, 11, 2016, 9
insert workhours select 15, 6, 21, 11, 2016, 8
insert workhours select 15, 6, 22, 11, 2016, 10
insert workhours select 15, 6, 23, 11, 2016, 6
insert workhours select 15, 6, 24, 11, 2016, 6
insert workhours select 15, 6, 25, 11, 2016, 7
insert workhours select 15, 6, 28, 11, 2016, 8
insert workhours select 15, 6, 29, 11, 2016, 8
insert workhours select 15, 6, 30, 11, 2016, 8
insert workhours select 15, 6, 1, 12, 2016, 8
insert workhours select 15, 6, 2, 12, 2016, 8
insert workhours select 15, 6, 5, 12, 2016, 8
insert workhours select 15, 6, 6, 12, 2016, 8
insert workhours select 15, 6, 7, 12, 2016, 8
insert workhours select 15, 6, 8, 12, 2016, 7
insert workhours select 15, 6, 9, 12, 2016, 7
insert workhours select 15, 6, 12, 12, 2016, 9
insert workhours select 15, 6, 13, 12, 2016, 9
insert workhours select 15, 6, 14, 12, 2016, 9
insert workhours select 15, 6, 15, 12, 2016, 9
insert workhours select 15, 6, 16, 12, 2016, 9
insert workhours select 15, 6, 19, 12, 2016, 9
insert workhours select 15, 6, 20, 12, 2016, 10
insert workhours select 15, 6, 21, 12, 2016, 10
insert workhours select 15, 6, 22, 12, 2016, 10
insert workhours select 15, 6, 23, 12, 2016, 10
insert workhours select 15, 6, 26, 12, 2016, 10
insert workhours select 15, 6, 27, 12, 2016, 10
insert workhours select 15, 6, 28, 12, 2016, 10
insert workhours select 15, 6, 29, 12, 2016, 10
insert workhours select 15, 6, 30, 12, 2016, 9
insert workhours select 15, 6, 2, 1, 2017, 9
insert workhours select 15, 6, 3, 1, 2017, 9
insert workhours select 15, 6, 4, 1, 2017, 9
insert workhours select 15, 6, 5, 1, 2017, 9
insert workhours select 15, 6, 6, 1, 2017, 9
insert workhours select 15, 6, 9, 1, 2017, 9
insert workhours select 15, 6, 10, 1, 2017, 6
insert workhours select 15, 6, 11, 1, 2017, 7
insert workhours select 15, 6, 12, 1, 2017, 8
insert workhours select 15, 6, 13, 1, 2017, 8
insert workhours select 15, 6, 16, 1, 2017, 8
insert workhours select 15, 6, 17, 1, 2017, 8
insert workhours select 15, 6, 18, 1, 2017, 9
insert workhours select 15, 6, 19, 1, 2017, 9
insert workhours select 15, 6, 20, 1, 2017, 9
insert workhours select 15, 6, 23, 1, 2017, 10
insert workhours select 15, 6, 24, 1, 2017, 9
insert workhours select 15, 6, 25, 1, 2017, 9
insert workhours select 15, 6, 26, 1, 2017, 9
insert workhours select 15, 6, 27, 1, 2017, 8
insert workhours select 15, 6, 30, 1, 2017, 8
insert workhours select 15, 6, 31, 1, 2017, 8
insert workhours select 15, 6, 1, 2, 2017, 8
insert workhours select 15, 6, 2, 2, 2017, 8
insert workhours select 15, 6, 3, 2, 2017, 8
insert workhours select 15, 6, 6, 2, 2017, 7
insert workhours select 15, 6, 7, 2, 2017, 10
insert workhours select 15, 6, 8, 2, 2017, 10
insert workhours select 15, 6, 9, 2, 2017, 10
insert workhours select 15, 6, 10, 2, 2017, 9
insert workhours select 15, 6, 13, 2, 2017, 8
insert workhours select 15, 6, 14, 2, 2017, 8
insert workhours select 15, 6, 15, 2, 2017, 8
insert workhours select 15, 6, 16, 2, 2017, 8
insert workhours select 15, 6, 17, 2, 2017, 8
insert workhours select 15, 6, 20, 2, 2017, 8
insert workhours select 15, 6, 21, 2, 2017, 8
insert workhours select 15, 6, 22, 2, 2017, 8
insert workhours select 15, 6, 23, 2, 2017, 8
insert workhours select 15, 6, 24, 2, 2017, 8
insert workhours select 15, 6, 27, 2, 2017, 9
insert workhours select 15, 6, 28, 2, 2017, 9
insert workhours select 15, 6, 1, 3, 2017, 9
insert workhours select 15, 6, 2, 3, 2017, 9
insert workhours select 15, 6, 3, 3, 2017, 10
insert workhours select 15, 6, 6, 3, 2017, 10
insert workhours select 15, 6, 7, 3, 2017, 10
insert workhours select 15, 6, 8, 3, 2017, 10
insert workhours select 15, 6, 9, 3, 2017, 11
insert workhours select 15, 6, 10, 3, 2017, 8
insert workhours select 15, 6, 13, 3, 2017, 8
insert workhours select 15, 6, 14, 3, 2017, 8
insert workhours select 15, 6, 15, 3, 2017, 8
insert workhours select 15, 6, 16, 3, 2017, 7
insert workhours select 15, 6, 17, 3, 2017, 5
insert workhours select 15, 6, 20, 3, 2017, 10
insert workhours select 15, 6, 21, 3, 2017, 10
insert workhours select 15, 6, 22, 3, 2017, 10
insert workhours select 15, 6, 23, 3, 2017, 8
insert workhours select 15, 6, 24, 3, 2017, 7
insert workhours select 15, 6, 27, 3, 2017, 8
insert workhours select 15, 6, 28, 3, 2017, 8
insert workhours select 15, 6, 29, 3, 2017, 9
insert workhours select 15, 6, 30, 3, 2017, 9
insert workhours select 15, 6, 31, 3, 2017, 9
insert workhours select 15, 6, 3, 4, 2017, 9
insert workhours select 15, 6, 4, 4, 2017, 9
insert workhours select 15, 6, 5, 4, 2017, 9
insert workhours select 15, 6, 6, 4, 2017, 9
insert workhours select 15, 6, 7, 4, 2017, 8
insert workhours select 15, 6, 10, 4, 2017, 10
insert workhours select 15, 6, 11, 4, 2017, 6
insert workhours select 15, 6, 12, 4, 2017, 6
insert workhours select 15, 6, 13, 4, 2017, 7
insert workhours select 15, 6, 14, 4, 2017, 8
insert workhours select 15, 6, 17, 4, 2017, 8
insert workhours select 15, 6, 18, 4, 2017, 8
insert workhours select 15, 6, 19, 4, 2017, 8
insert workhours select 15, 6, 20, 4, 2017, 8
insert workhours select 15, 6, 21, 4, 2017, 8
insert workhours select 15, 6, 24, 4, 2017, 8
insert workhours select 15, 6, 25, 4, 2017, 8
insert workhours select 15, 6, 26, 4, 2017, 7
insert workhours select 15, 6, 27, 4, 2017, 7
insert workhours select 15, 6, 28, 4, 2017, 9
insert workhours select 15, 6, 1, 5, 2017, 9
insert workhours select 15, 6, 2, 5, 2017, 9
insert workhours select 15, 6, 3, 5, 2017, 9
insert workhours select 15, 6, 4, 5, 2017, 9
insert workhours select 15, 6, 5, 5, 2017, 9
insert workhours select 15, 6, 8, 5, 2017, 10
insert workhours select 15, 6, 9, 5, 2017, 10
insert workhours select 15, 6, 10, 5, 2017, 10
insert workhours select 15, 6, 11, 5, 2017, 10
insert workhours select 15, 6, 12, 5, 2017, 10
insert workhours select 15, 6, 15, 5, 2017, 10
insert workhours select 15, 6, 16, 5, 2017, 10
insert workhours select 15, 6, 17, 5, 2017, 10
insert workhours select 15, 6, 18, 5, 2017, 9
insert workhours select 15, 6, 19, 5, 2017, 9
insert workhours select 15, 6, 22, 5, 2017, 9
insert workhours select 15, 6, 23, 5, 2017, 9
insert workhours select 15, 6, 24, 5, 2017, 9
insert workhours select 15, 6, 25, 5, 2017, 9
insert workhours select 15, 6, 26, 5, 2017, 9
insert workhours select 15, 6, 29, 5, 2017, 6
insert workhours select 15, 6, 30, 5, 2017, 7
insert workhours select 15, 6, 31, 5, 2017, 8
insert workhours select 15, 6, 1, 6, 2017, 8
insert workhours select 15, 6, 2, 6, 2017, 8
insert workhours select 15, 6, 5, 6, 2017, 8
insert workhours select 15, 6, 6, 6, 2017, 9
insert workhours select 15, 6, 7, 6, 2017, 9
insert workhours select 15, 6, 8, 6, 2017, 9
insert workhours select 15, 6, 9, 6, 2017, 10
insert workhours select 15, 6, 12, 6, 2017, 9
insert workhours select 15, 6, 13, 6, 2017, 9
insert workhours select 15, 6, 14, 6, 2017, 9
insert workhours select 15, 6, 15, 6, 2017, 8
insert workhours select 15, 6, 16, 6, 2017, 8
insert workhours select 15, 6, 19, 6, 2017, 8
insert workhours select 15, 6, 20, 6, 2017, 8
insert workhours select 15, 6, 21, 6, 2017, 8
insert workhours select 15, 6, 22, 6, 2017, 8
insert workhours select 15, 6, 23, 6, 2017, 8
insert workhours select 15, 6, 26, 6, 2017, 8
insert workhours select 15, 6, 27, 6, 2017, 7
insert workhours select 15, 6, 28, 6, 2017, 10
insert workhours select 15, 6, 29, 6, 2017, 10
insert workhours select 15, 6, 30, 6, 2017, 10
insert workhours select 15, 6, 3, 7, 2017, 9
insert workhours select 15, 6, 4, 7, 2017, 8
insert workhours select 15, 6, 5, 7, 2017, 8
insert workhours select 15, 6, 6, 7, 2017, 8
insert workhours select 15, 6, 7, 7, 2017, 8
insert workhours select 15, 6, 10, 7, 2017, 8
insert workhours select 15, 6, 11, 7, 2017, 8
insert workhours select 15, 6, 12, 7, 2017, 8
insert workhours select 15, 6, 13, 7, 2017, 8
insert workhours select 15, 6, 14, 7, 2017, 8
insert workhours select 15, 6, 17, 7, 2017, 8
insert workhours select 15, 6, 18, 7, 2017, 9
insert workhours select 15, 6, 19, 7, 2017, 9
insert workhours select 15, 6, 20, 7, 2017, 9
insert workhours select 15, 6, 21, 7, 2017, 9
insert workhours select 15, 6, 24, 7, 2017, 10
insert workhours select 15, 6, 25, 7, 2017, 10
insert workhours select 15, 6, 26, 7, 2017, 10
insert workhours select 15, 6, 27, 7, 2017, 10
insert workhours select 15, 6, 28, 7, 2017, 11
insert workhours select 15, 6, 31, 7, 2017, 8
insert workhours select 15, 6, 1, 8, 2017, 8
insert workhours select 15, 6, 2, 8, 2017, 8
insert workhours select 15, 6, 3, 8, 2017, 8
insert workhours select 15, 6, 4, 8, 2017, 7
insert workhours select 15, 6, 7, 8, 2017, 5
insert workhours select 15, 6, 8, 8, 2017, 10
insert workhours select 15, 6, 9, 8, 2017, 10
insert workhours select 15, 6, 10, 8, 2017, 10
insert workhours select 15, 6, 11, 8, 2017, 8
insert workhours select 15, 6, 14, 8, 2017, 7
insert workhours select 15, 6, 15, 8, 2017, 8
insert workhours select 15, 6, 16, 8, 2017, 8
insert workhours select 15, 6, 17, 8, 2017, 9
insert workhours select 15, 6, 18, 8, 2017, 9
insert workhours select 15, 6, 21, 8, 2017, 9
insert workhours select 15, 6, 22, 8, 2017, 9
insert workhours select 15, 6, 23, 8, 2017, 9
insert workhours select 15, 6, 24, 8, 2017, 9
insert workhours select 15, 6, 25, 8, 2017, 9
insert workhours select 15, 6, 28, 8, 2017, 8
insert workhours select 15, 6, 29, 8, 2017, 10
insert workhours select 15, 6, 30, 8, 2017, 6
insert workhours select 15, 6, 31, 8, 2017, 6
insert workhours select 15, 6, 1, 9, 2017, 7
insert workhours select 15, 6, 4, 9, 2017, 8
insert workhours select 15, 6, 5, 9, 2017, 8
insert workhours select 15, 6, 6, 9, 2017, 8
insert workhours select 15, 6, 7, 9, 2017, 8
insert workhours select 15, 6, 8, 9, 2017, 8
insert workhours select 15, 6, 11, 9, 2017, 8
insert workhours select 15, 6, 12, 9, 2017, 8
insert workhours select 15, 6, 13, 9, 2017, 8
insert workhours select 15, 6, 14, 9, 2017, 7
insert workhours select 15, 6, 15, 9, 2017, 7
insert workhours select 15, 6, 18, 9, 2017, 9
insert workhours select 15, 6, 19, 9, 2017, 9
insert workhours select 15, 6, 20, 9, 2017, 9
insert workhours select 15, 6, 21, 9, 2017, 9
insert workhours select 15, 6, 22, 9, 2017, 9
insert workhours select 15, 6, 25, 9, 2017, 9
insert workhours select 15, 6, 26, 9, 2017, 10
insert workhours select 15, 6, 27, 9, 2017, 10
insert workhours select 15, 6, 28, 9, 2017, 10
insert workhours select 15, 6, 29, 9, 2017, 10
insert workhours select 16, 2, 1, 1, 2017, 10
insert workhours select 16, 2, 2, 1, 2017, 10
insert workhours select 16, 2, 3, 1, 2017, 10
insert workhours select 16, 2, 4, 1, 2017, 10
insert workhours select 16, 2, 5, 1, 2017, 9
insert workhours select 16, 2, 6, 1, 2017, 9
insert workhours select 16, 2, 9, 1, 2017, 9
insert workhours select 16, 2, 10, 1, 2017, 9
insert workhours select 16, 2, 11, 1, 2017, 9
insert workhours select 16, 2, 12, 1, 2017, 9
insert workhours select 16, 2, 13, 1, 2017, 9
insert workhours select 16, 2, 16, 1, 2017, 6
insert workhours select 16, 2, 17, 1, 2017, 7
insert workhours select 16, 2, 18, 1, 2017, 8
insert workhours select 16, 2, 19, 1, 2017, 8
insert workhours select 16, 2, 20, 1, 2017, 8
insert workhours select 16, 2, 23, 1, 2017, 8
insert workhours select 16, 2, 24, 1, 2017, 9
insert workhours select 16, 2, 25, 1, 2017, 9
insert workhours select 16, 2, 26, 1, 2017, 9
insert workhours select 16, 2, 27, 1, 2017, 10
insert workhours select 16, 2, 30, 1, 2017, 9
insert workhours select 16, 2, 31, 1, 2017, 9
insert workhours select 16, 2, 1, 2, 2017, 8
insert workhours select 16, 2, 2, 2, 2017, 8
insert workhours select 16, 2, 3, 2, 2017, 8
insert workhours select 16, 2, 6, 2, 2017, 8
insert workhours select 16, 2, 7, 2, 2017, 8
insert workhours select 16, 2, 8, 2, 2017, 7
insert workhours select 16, 2, 9, 2, 2017, 10
insert workhours select 16, 2, 10, 2, 2017, 10
insert workhours select 16, 2, 13, 2, 2017, 10
insert workhours select 16, 2, 14, 2, 2017, 9
insert workhours select 16, 2, 15, 2, 2017, 8
insert workhours select 16, 2, 16, 2, 2017, 8
insert workhours select 16, 2, 17, 2, 2017, 8
insert workhours select 16, 2, 20, 2, 2017, 8
insert workhours select 16, 2, 21, 2, 2017, 8
insert workhours select 16, 2, 22, 2, 2017, 8
insert workhours select 16, 2, 23, 2, 2017, 8
insert workhours select 16, 2, 24, 2, 2017, 8
insert workhours select 16, 2, 27, 2, 2017, 8
insert workhours select 16, 2, 28, 2, 2017, 8
insert workhours select 16, 2, 1, 3, 2017, 9
insert workhours select 16, 2, 2, 3, 2017, 9
insert workhours select 16, 2, 3, 3, 2017, 9
insert workhours select 16, 2, 6, 3, 2017, 9
insert workhours select 16, 2, 7, 3, 2017, 10
insert workhours select 16, 2, 8, 3, 2017, 10
insert workhours select 16, 2, 9, 3, 2017, 10
insert workhours select 16, 2, 10, 3, 2017, 10
insert workhours select 16, 2, 13, 3, 2017, 11
insert workhours select 16, 2, 14, 3, 2017, 8
insert workhours select 16, 2, 15, 3, 2017, 8
insert workhours select 17, 6, 1, 1, 2017, 8
insert workhours select 17, 6, 2, 1, 2017, 8
insert workhours select 17, 6, 3, 1, 2017, 7
insert workhours select 17, 6, 4, 1, 2017, 5
insert workhours select 17, 6, 5, 1, 2017, 10
insert workhours select 17, 6, 6, 1, 2017, 10
insert workhours select 17, 6, 9, 1, 2017, 10
insert workhours select 17, 6, 10, 1, 2017, 8
insert workhours select 17, 6, 11, 1, 2017, 7
insert workhours select 17, 6, 12, 1, 2017, 8
insert workhours select 17, 6, 13, 1, 2017, 8
insert workhours select 17, 6, 16, 1, 2017, 9
insert workhours select 17, 6, 17, 1, 2017, 9
insert workhours select 17, 6, 18, 1, 2017, 9
insert workhours select 17, 6, 19, 1, 2017, 9
insert workhours select 17, 6, 20, 1, 2017, 9
insert workhours select 17, 6, 23, 1, 2017, 9
insert workhours select 17, 6, 24, 1, 2017, 9
insert workhours select 17, 6, 25, 1, 2017, 8
insert workhours select 17, 6, 26, 1, 2017, 10
insert workhours select 17, 6, 27, 1, 2017, 6
insert workhours select 17, 6, 30, 1, 2017, 6
insert workhours select 17, 6, 31, 1, 2017, 7
insert workhours select 17, 6, 1, 2, 2017, 8
insert workhours select 17, 6, 2, 2, 2017, 8
insert workhours select 17, 6, 3, 2, 2017, 8
insert workhours select 17, 6, 6, 2, 2017, 8
insert workhours select 17, 6, 7, 2, 2017, 8
insert workhours select 17, 6, 8, 2, 2017, 8
insert workhours select 17, 6, 9, 2, 2017, 8
insert workhours select 17, 6, 10, 2, 2017, 8
insert workhours select 17, 6, 13, 2, 2017, 7
insert workhours select 17, 6, 14, 2, 2017, 7
insert workhours select 17, 6, 15, 2, 2017, 9
insert workhours select 17, 6, 16, 2, 2017, 9
insert workhours select 17, 6, 17, 2, 2017, 9
insert workhours select 17, 6, 20, 2, 2017, 9
insert workhours select 17, 6, 21, 2, 2017, 9
insert workhours select 17, 6, 22, 2, 2017, 9
insert workhours select 17, 6, 23, 2, 2017, 10
insert workhours select 17, 6, 24, 2, 2017, 10
insert workhours select 17, 6, 27, 2, 2017, 10
insert workhours select 17, 6, 28, 2, 2017, 10
insert workhours select 17, 6, 1, 3, 2017, 10
insert workhours select 17, 6, 2, 3, 2017, 10
insert workhours select 17, 6, 3, 3, 2017, 10
insert workhours select 17, 6, 6, 3, 2017, 10
insert workhours select 17, 6, 7, 3, 2017, 9
insert workhours select 17, 6, 8, 3, 2017, 9
insert workhours select 17, 6, 9, 3, 2017, 9
insert workhours select 17, 6, 10, 3, 2017, 9
insert workhours select 17, 6, 13, 3, 2017, 9
insert workhours select 17, 6, 14, 3, 2017, 9
insert workhours select 17, 6, 15, 3, 2017, 9
insert workhours select 17, 6, 16, 3, 2017, 6
insert workhours select 17, 6, 17, 3, 2017, 7
insert workhours select 17, 6, 20, 3, 2017, 8
insert workhours select 17, 6, 21, 3, 2017, 8
insert workhours select 17, 6, 22, 3, 2017, 8
insert workhours select 17, 6, 23, 3, 2017, 8
insert workhours select 17, 6, 24, 3, 2017, 9
insert workhours select 17, 6, 27, 3, 2017, 9
insert workhours select 17, 6, 28, 3, 2017, 9
insert workhours select 17, 6, 29, 3, 2017, 10
insert workhours select 17, 6, 30, 3, 2017, 9
insert workhours select 17, 6, 31, 3, 2017, 9
insert workhours select 17, 6, 1, 4, 2017, 9
insert workhours select 17, 6, 2, 4, 2017, 8
insert workhours select 18, 2, 1, 5, 2017, 8
insert workhours select 18, 2, 2, 5, 2017, 8
insert workhours select 18, 2, 3, 5, 2017, 8
insert workhours select 18, 2, 4, 5, 2017, 8
insert workhours select 18, 2, 5, 5, 2017, 8
insert workhours select 18, 2, 8, 5, 2017, 7
insert workhours select 18, 2, 9, 5, 2017, 10
insert workhours select 18, 2, 10, 5, 2017, 10
insert workhours select 18, 2, 11, 5, 2017, 10
insert workhours select 18, 2, 12, 5, 2017, 9
insert workhours select 18, 2, 15, 5, 2017, 8
insert workhours select 18, 2, 16, 5, 2017, 8
insert workhours select 18, 2, 17, 5, 2017, 8
insert workhours select 18, 2, 18, 5, 2017, 8
insert workhours select 18, 2, 19, 5, 2017, 8
insert workhours select 18, 2, 22, 5, 2017, 8
insert workhours select 18, 2, 23, 5, 2017, 8
insert workhours select 18, 2, 24, 5, 2017, 8
insert workhours select 18, 2, 25, 5, 2017, 8
insert workhours select 18, 2, 26, 5, 2017, 8
insert workhours select 18, 2, 29, 5, 2017, 9
insert workhours select 18, 2, 30, 5, 2017, 9
insert workhours select 18, 2, 31, 5, 2017, 9
insert workhours select 18, 2, 1, 6, 2017, 9
insert workhours select 18, 2, 2, 6, 2017, 10
insert workhours select 18, 2, 5, 6, 2017, 10
insert workhours select 18, 2, 6, 6, 2017, 10
insert workhours select 18, 2, 7, 6, 2017, 10
insert workhours select 18, 2, 8, 6, 2017, 11
insert workhours select 18, 2, 9, 6, 2017, 8
insert workhours select 18, 2, 12, 6, 2017, 8
insert workhours select 18, 2, 13, 6, 2017, 8
insert workhours select 18, 2, 14, 6, 2017, 8
insert workhours select 18, 2, 15, 6, 2017, 7
insert workhours select 18, 2, 16, 6, 2017, 5
insert workhours select 18, 2, 19, 6, 2017, 10
insert workhours select 18, 2, 20, 6, 2017, 10
insert workhours select 18, 2, 21, 6, 2017, 10
insert workhours select 18, 2, 22, 6, 2017, 8
insert workhours select 18, 2, 23, 6, 2017, 7
insert workhours select 18, 2, 26, 6, 2017, 8
insert workhours select 18, 2, 27, 6, 2017, 8
insert workhours select 18, 2, 28, 6, 2017, 9
insert workhours select 18, 2, 29, 6, 2017, 9
insert workhours select 18, 2, 30, 6, 2017, 9
insert workhours select 18, 2, 3, 7, 2017, 9
insert workhours select 18, 2, 4, 7, 2017, 9
insert workhours select 18, 2, 5, 7, 2017, 9
insert workhours select 18, 2, 6, 7, 2017, 9
insert workhours select 18, 2, 7, 7, 2017, 8
insert workhours select 18, 2, 10, 7, 2017, 10
insert workhours select 18, 2, 11, 7, 2017, 6
insert workhours select 18, 2, 12, 7, 2017, 6
insert workhours select 18, 2, 13, 7, 2017, 7
insert workhours select 18, 2, 14, 7, 2017, 8
insert workhours select 18, 2, 17, 7, 2017, 8
insert workhours select 18, 2, 18, 7, 2017, 8
insert workhours select 18, 2, 19, 7, 2017, 8
insert workhours select 18, 2, 20, 7, 2017, 8
insert workhours select 18, 2, 21, 7, 2017, 8
insert workhours select 18, 2, 24, 7, 2017, 8
insert workhours select 18, 2, 25, 7, 2017, 8
insert workhours select 18, 2, 26, 7, 2017, 7
insert workhours select 18, 2, 27, 7, 2017, 7
insert workhours select 18, 2, 28, 7, 2017, 9
insert workhours select 18, 2, 31, 7, 2017, 9
insert workhours select 18, 2, 1, 8, 2017, 9
insert workhours select 18, 2, 2, 8, 2017, 9
insert workhours select 18, 2, 3, 8, 2017, 9
insert workhours select 18, 2, 4, 8, 2017, 9
insert workhours select 18, 2, 7, 8, 2017, 10
insert workhours select 18, 2, 8, 8, 2017, 10
insert workhours select 18, 2, 9, 8, 2017, 10
insert workhours select 18, 2, 10, 8, 2017, 10
insert workhours select 18, 2, 11, 8, 2017, 10
insert workhours select 18, 2, 14, 8, 2017, 10
insert workhours select 18, 2, 15, 8, 2017, 10
insert workhours select 18, 2, 16, 8, 2017, 10
insert workhours select 18, 2, 17, 8, 2017, 9
insert workhours select 18, 2, 18, 8, 2017, 9
insert workhours select 18, 2, 21, 8, 2017, 9
insert workhours select 18, 2, 22, 8, 2017, 9
insert workhours select 18, 2, 23, 8, 2017, 9
insert workhours select 18, 2, 24, 8, 2017, 9
insert workhours select 18, 2, 25, 8, 2017, 9
insert workhours select 18, 2, 28, 8, 2017, 6
insert workhours select 18, 2, 29, 8, 2017, 7
insert workhours select 18, 2, 30, 8, 2017, 8
insert workhours select 18, 2, 31, 8, 2017, 8
insert workhours select 18, 2, 1, 9, 2017, 8
insert workhours select 18, 2, 4, 9, 2017, 8
insert workhours select 18, 2, 5, 9, 2017, 9
insert workhours select 18, 2, 6, 9, 2017, 9
insert workhours select 18, 2, 7, 9, 2017, 9
insert workhours select 18, 2, 8, 9, 2017, 10
insert workhours select 18, 2, 11, 9, 2017, 9
insert workhours select 18, 2, 12, 9, 2017, 9
insert workhours select 18, 2, 13, 9, 2017, 9
insert workhours select 18, 2, 14, 9, 2017, 8
insert workhours select 18, 2, 15, 9, 2017, 8
insert workhours select 18, 2, 18, 9, 2017, 8
insert workhours select 18, 2, 19, 9, 2017, 8
insert workhours select 18, 2, 20, 9, 2017, 8
insert workhours select 18, 2, 21, 9, 2017, 8
insert workhours select 18, 2, 22, 9, 2017, 8
insert workhours select 18, 2, 25, 9, 2017, 8
insert workhours select 18, 2, 26, 9, 2017, 8
insert workhours select 18, 2, 27, 9, 2017, 8
insert workhours select 18, 2, 28, 9, 2017, 8
insert workhours select 18, 2, 29, 9, 2017, 8
insert workhours select 18, 6, 1, 5, 2017, 8
insert workhours select 18, 6, 2, 5, 2017, 8
insert workhours select 18, 6, 3, 5, 2017, 8
insert workhours select 18, 6, 4, 5, 2017, 8
insert workhours select 18, 6, 5, 5, 2017, 8
insert workhours select 18, 6, 8, 5, 2017, 7
insert workhours select 18, 6, 9, 5, 2017, 10
insert workhours select 18, 6, 10, 5, 2017, 10
insert workhours select 18, 6, 11, 5, 2017, 10
insert workhours select 18, 6, 12, 5, 2017, 9
insert workhours select 18, 6, 15, 5, 2017, 8
insert workhours select 18, 6, 16, 5, 2017, 8
insert workhours select 18, 6, 17, 5, 2017, 8
insert workhours select 18, 6, 18, 5, 2017, 8
insert workhours select 18, 6, 19, 5, 2017, 8
insert workhours select 18, 6, 22, 5, 2017, 8
insert workhours select 18, 6, 23, 5, 2017, 8
insert workhours select 18, 6, 24, 5, 2017, 8
insert workhours select 18, 6, 25, 5, 2017, 8
insert workhours select 18, 6, 26, 5, 2017, 8
insert workhours select 18, 6, 29, 5, 2017, 9
insert workhours select 18, 6, 30, 5, 2017, 9
insert workhours select 18, 6, 31, 5, 2017, 9
insert workhours select 18, 6, 1, 6, 2017, 9
insert workhours select 18, 6, 2, 6, 2017, 10
insert workhours select 18, 6, 5, 6, 2017, 10
insert workhours select 18, 6, 6, 6, 2017, 10
insert workhours select 18, 6, 7, 6, 2017, 10
insert workhours select 18, 6, 8, 6, 2017, 11
insert workhours select 18, 6, 9, 6, 2017, 8
insert workhours select 18, 6, 12, 6, 2017, 8
insert workhours select 18, 6, 13, 6, 2017, 8
insert workhours select 18, 6, 14, 6, 2017, 8
insert workhours select 18, 6, 15, 6, 2017, 7
insert workhours select 18, 6, 16, 6, 2017, 5
insert workhours select 18, 6, 19, 6, 2017, 10
insert workhours select 18, 6, 20, 6, 2017, 10
insert workhours select 18, 6, 21, 6, 2017, 10
insert workhours select 18, 6, 22, 6, 2017, 8
insert workhours select 18, 6, 23, 6, 2017, 7
insert workhours select 18, 6, 26, 6, 2017, 8
insert workhours select 18, 6, 27, 6, 2017, 8
insert workhours select 18, 6, 28, 6, 2017, 9
insert workhours select 18, 6, 29, 6, 2017, 9
insert workhours select 18, 6, 30, 6, 2017, 9
insert workhours select 18, 6, 3, 7, 2017, 9
insert workhours select 18, 6, 4, 7, 2017, 9
insert workhours select 18, 6, 5, 7, 2017, 9
insert workhours select 18, 6, 6, 7, 2017, 9
insert workhours select 18, 6, 7, 7, 2017, 8
insert workhours select 18, 6, 10, 7, 2017, 10
insert workhours select 18, 6, 11, 7, 2017, 6
insert workhours select 18, 6, 12, 7, 2017, 6
insert workhours select 18, 6, 13, 7, 2017, 7
insert workhours select 18, 6, 14, 7, 2017, 8
insert workhours select 18, 6, 17, 7, 2017, 8
insert workhours select 18, 6, 18, 7, 2017, 8
insert workhours select 18, 6, 19, 7, 2017, 8
insert workhours select 18, 6, 20, 7, 2017, 8
insert workhours select 18, 6, 21, 7, 2017, 8
insert workhours select 18, 6, 24, 7, 2017, 8
insert workhours select 18, 6, 25, 7, 2017, 8
insert workhours select 18, 6, 26, 7, 2017, 7
insert workhours select 18, 6, 27, 7, 2017, 7
insert workhours select 18, 6, 28, 7, 2017, 9
insert workhours select 18, 6, 31, 7, 2017, 9
insert workhours select 18, 6, 1, 8, 2017, 9
insert workhours select 18, 6, 2, 8, 2017, 9
insert workhours select 18, 6, 3, 8, 2017, 9
insert workhours select 18, 6, 4, 8, 2017, 9
insert workhours select 18, 6, 7, 8, 2017, 10
insert workhours select 18, 6, 8, 8, 2017, 10
insert workhours select 18, 6, 9, 8, 2017, 10
insert workhours select 18, 6, 10, 8, 2017, 10
insert workhours select 18, 6, 11, 8, 2017, 10
insert workhours select 18, 6, 14, 8, 2017, 10
insert workhours select 18, 6, 15, 8, 2017, 10
insert workhours select 18, 6, 16, 8, 2017, 10
insert workhours select 18, 6, 17, 8, 2017, 9
insert workhours select 18, 6, 18, 8, 2017, 9
insert workhours select 18, 6, 21, 8, 2017, 9
insert workhours select 18, 6, 22, 8, 2017, 9
insert workhours select 18, 6, 23, 8, 2017, 9
insert workhours select 18, 6, 24, 8, 2017, 9
insert workhours select 18, 6, 25, 8, 2017, 9
insert workhours select 18, 6, 28, 8, 2017, 6
insert workhours select 18, 6, 29, 8, 2017, 7
insert workhours select 18, 6, 30, 8, 2017, 8
insert workhours select 18, 6, 31, 8, 2017, 8
insert workhours select 18, 6, 1, 9, 2017, 8
insert workhours select 18, 6, 4, 9, 2017, 8
insert workhours select 18, 6, 5, 9, 2017, 9
insert workhours select 18, 6, 6, 9, 2017, 9
insert workhours select 18, 6, 7, 9, 2017, 9
insert workhours select 18, 6, 8, 9, 2017, 10
insert workhours select 18, 6, 11, 9, 2017, 9
insert workhours select 18, 6, 12, 9, 2017, 9
insert workhours select 18, 6, 13, 9, 2017, 8
insert workhours select 18, 6, 14, 9, 2017, 8
insert workhours select 18, 6, 15, 9, 2017, 8
insert workhours select 18, 6, 18, 9, 2017, 8
insert workhours select 18, 6, 19, 9, 2017, 8
insert workhours select 18, 6, 20, 9, 2017, 7
insert workhours select 18, 6, 21, 9, 2017, 10
insert workhours select 18, 6, 22, 9, 2017, 10
insert workhours select 18, 6, 25, 9, 2017, 10
insert workhours select 18, 6, 26, 9, 2017, 9
insert workhours select 18, 6, 27, 9, 2017, 8
insert workhours select 18, 6, 28, 9, 2017, 8
insert workhours select 18, 6, 29, 9, 2017, 8
insert workhours select 20, 4, 20, 2, 2017, 8
insert workhours select 20, 4, 21, 2, 2017, 8
insert workhours select 20, 4, 22, 2, 2017, 8
insert workhours select 20, 4, 23, 2, 2017, 8
insert workhours select 20, 4, 24, 2, 2017, 8
insert workhours select 20, 4, 27, 2, 2017, 8
insert workhours select 20, 4, 28, 2, 2017, 8
insert workhours select 20, 4, 1, 3, 2017, 9
insert workhours select 20, 4, 2, 3, 2017, 9
insert workhours select 20, 4, 3, 3, 2017, 9
insert workhours select 20, 4, 6, 3, 2017, 9
insert workhours select 20, 4, 7, 3, 2017, 10
insert workhours select 20, 4, 8, 3, 2017, 10
insert workhours select 20, 4, 9, 3, 2017, 10
insert workhours select 20, 4, 10, 3, 2017, 10
insert workhours select 20, 4, 13, 3, 2017, 11
insert workhours select 20, 4, 14, 3, 2017, 8
insert workhours select 20, 4, 15, 3, 2017, 8
insert workhours select 20, 4, 16, 3, 2017, 8
insert workhours select 20, 4, 17, 3, 2017, 8
insert workhours select 20, 4, 20, 3, 2017, 7
insert workhours select 20, 4, 21, 3, 2017, 5
insert workhours select 20, 4, 22, 3, 2017, 10
insert workhours select 20, 4, 23, 3, 2017, 10
insert workhours select 20, 4, 24, 3, 2017, 10
insert workhours select 20, 4, 27, 3, 2017, 8
insert workhours select 20, 4, 28, 3, 2017, 7
insert workhours select 20, 4, 29, 3, 2017, 8
insert workhours select 20, 4, 30, 3, 2017, 8
insert workhours select 20, 4, 31, 3, 2017, 9
insert workhours select 20, 4, 3, 4, 2017, 9
insert workhours select 20, 4, 4, 4, 2017, 9
insert workhours select 20, 4, 5, 4, 2017, 9
insert workhours select 20, 4, 6, 4, 2017, 9
insert workhours select 20, 4, 7, 4, 2017, 9
insert workhours select 20, 4, 10, 4, 2017, 9
insert workhours select 20, 4, 11, 4, 2017, 8
insert workhours select 20, 4, 12, 4, 2017, 10
insert workhours select 20, 4, 13, 4, 2017, 6
insert workhours select 20, 4, 14, 4, 2017, 6
insert workhours select 20, 4, 17, 4, 2017, 7
insert workhours select 20, 4, 18, 4, 2017, 8
insert workhours select 20, 4, 19, 4, 2017, 8
insert workhours select 20, 4, 20, 4, 2017, 8
insert workhours select 20, 4, 21, 4, 2017, 8
insert workhours select 20, 4, 24, 4, 2017, 8
insert workhours select 20, 4, 25, 4, 2017, 8
insert workhours select 20, 4, 26, 4, 2017, 8
insert workhours select 20, 4, 27, 4, 2017, 8
insert workhours select 20, 4, 28, 4, 2017, 7
insert workhours select 20, 4, 1, 5, 2017, 7
insert workhours select 20, 4, 2, 5, 2017, 9
insert workhours select 20, 4, 3, 5, 2017, 9
insert workhours select 20, 4, 4, 5, 2017, 9
insert workhours select 20, 4, 5, 5, 2017, 9
insert workhours select 20, 4, 8, 5, 2017, 9
insert workhours select 20, 4, 9, 5, 2017, 9
insert workhours select 20, 4, 10, 5, 2017, 10
insert workhours select 20, 4, 11, 5, 2017, 10
insert workhours select 20, 4, 12, 5, 2017, 10
insert workhours select 20, 4, 15, 5, 2017, 10
insert workhours select 20, 4, 16, 5, 2017, 10
insert workhours select 20, 4, 17, 5, 2017, 10
insert workhours select 20, 4, 18, 5, 2017, 10
insert workhours select 20, 4, 19, 5, 2017, 10
insert workhours select 20, 4, 22, 5, 2017, 9
insert workhours select 20, 4, 23, 5, 2017, 9
insert workhours select 20, 4, 24, 5, 2017, 9
insert workhours select 20, 4, 25, 5, 2017, 9
insert workhours select 20, 4, 26, 5, 2017, 9
insert workhours select 20, 4, 29, 5, 2017, 9
insert workhours select 20, 4, 30, 5, 2017, 9
insert workhours select 20, 4, 31, 5, 2017, 6
insert workhours select 20, 4, 1, 6, 2017, 7
insert workhours select 20, 4, 2, 6, 2017, 8
insert workhours select 20, 4, 5, 6, 2017, 8
insert workhours select 20, 4, 6, 6, 2017, 8
insert workhours select 20, 4, 7, 6, 2017, 8
insert workhours select 20, 4, 8, 6, 2017, 9
insert workhours select 20, 4, 9, 6, 2017, 9
insert workhours select 20, 4, 12, 6, 2017, 9
insert workhours select 20, 4, 13, 6, 2017, 10
insert workhours select 20, 4, 14, 6, 2017, 9
insert workhours select 20, 4, 15, 6, 2017, 8
insert workhours select 20, 4, 16, 6, 2017, 8
insert workhours select 20, 4, 19, 6, 2017, 8
insert workhours select 20, 4, 20, 6, 2017, 8
insert workhours select 20, 4, 21, 6, 2017, 8
insert workhours select 20, 4, 22, 6, 2017, 7
insert workhours select 20, 4, 23, 6, 2017, 10
insert workhours select 20, 4, 26, 6, 2017, 10
insert workhours select 20, 4, 27, 6, 2017, 10
insert workhours select 20, 4, 28, 6, 2017, 9
insert workhours select 20, 4, 29, 6, 2017, 8
insert workhours select 20, 4, 30, 6, 2017, 8
insert workhours select 20, 4, 3, 7, 2017, 8
insert workhours select 20, 4, 4, 7, 2017, 8
insert workhours select 20, 4, 5, 7, 2017, 8
insert workhours select 20, 4, 6, 7, 2017, 8
insert workhours select 20, 4, 7, 7, 2017, 8
insert workhours select 20, 4, 10, 7, 2017, 8
insert workhours select 20, 4, 11, 7, 2017, 8
insert workhours select 20, 4, 12, 7, 2017, 8
insert workhours select 20, 4, 13, 7, 2017, 9
insert workhours select 20, 4, 14, 7, 2017, 9
insert workhours select 20, 4, 17, 7, 2017, 9
insert workhours select 20, 4, 18, 7, 2017, 9
insert workhours select 20, 4, 19, 7, 2017, 10
insert workhours select 20, 4, 20, 7, 2017, 10
insert workhours select 20, 4, 21, 7, 2017, 10
insert workhours select 20, 4, 24, 7, 2017, 10
insert workhours select 20, 4, 25, 7, 2017, 11
insert workhours select 20, 4, 26, 7, 2017, 8
insert workhours select 20, 4, 27, 7, 2017, 8
insert workhours select 20, 4, 28, 7, 2017, 8
insert workhours select 20, 4, 31, 7, 2017, 8
insert workhours select 20, 5, 20, 2, 2017, 7
insert workhours select 20, 5, 21, 2, 2017, 5
insert workhours select 20, 5, 22, 2, 2017, 10
insert workhours select 20, 5, 23, 2, 2017, 10
insert workhours select 20, 5, 24, 2, 2017, 10
insert workhours select 20, 5, 27, 2, 2017, 8
insert workhours select 20, 5, 28, 2, 2017, 7
insert workhours select 20, 5, 1, 3, 2017, 8
insert workhours select 20, 5, 2, 3, 2017, 8
insert workhours select 20, 5, 3, 3, 2017, 9
insert workhours select 20, 5, 6, 3, 2017, 9
insert workhours select 20, 5, 7, 3, 2017, 9
insert workhours select 20, 5, 8, 3, 2017, 9
insert workhours select 20, 5, 9, 3, 2017, 9
insert workhours select 20, 5, 10, 3, 2017, 9
insert workhours select 20, 5, 13, 3, 2017, 9
insert workhours select 20, 5, 14, 3, 2017, 8
insert workhours select 20, 5, 15, 3, 2017, 10
insert workhours select 20, 5, 16, 3, 2017, 6
insert workhours select 20, 5, 17, 3, 2017, 6
insert workhours select 20, 5, 20, 3, 2017, 7
insert workhours select 20, 5, 21, 3, 2017, 8
insert workhours select 20, 5, 22, 3, 2017, 8
insert workhours select 20, 5, 23, 3, 2017, 8
insert workhours select 20, 5, 24, 3, 2017, 8
insert workhours select 20, 5, 27, 3, 2017, 8
insert workhours select 20, 5, 28, 3, 2017, 8
insert workhours select 20, 5, 29, 3, 2017, 8
insert workhours select 20, 5, 30, 3, 2017, 8
insert workhours select 20, 5, 31, 3, 2017, 7
insert workhours select 20, 5, 3, 4, 2017, 7
insert workhours select 20, 5, 4, 4, 2017, 9
insert workhours select 20, 5, 5, 4, 2017, 9
insert workhours select 20, 5, 6, 4, 2017, 9
insert workhours select 20, 5, 7, 4, 2017, 9
insert workhours select 20, 5, 10, 4, 2017, 9
insert workhours select 20, 5, 11, 4, 2017, 9
insert workhours select 20, 5, 12, 4, 2017, 10
insert workhours select 20, 5, 13, 4, 2017, 10
insert workhours select 20, 5, 14, 4, 2017, 10
insert workhours select 20, 5, 17, 4, 2017, 10
insert workhours select 20, 5, 18, 4, 2017, 10
insert workhours select 20, 5, 19, 4, 2017, 10
insert workhours select 20, 5, 20, 4, 2017, 10
insert workhours select 20, 5, 21, 4, 2017, 10
insert workhours select 20, 5, 24, 4, 2017, 9
insert workhours select 20, 5, 25, 4, 2017, 9
insert workhours select 20, 5, 26, 4, 2017, 9
insert workhours select 20, 5, 27, 4, 2017, 9
insert workhours select 20, 5, 28, 4, 2017, 9
insert workhours select 20, 5, 1, 5, 2017, 9
insert workhours select 20, 5, 2, 5, 2017, 9
insert workhours select 20, 5, 3, 5, 2017, 6
insert workhours select 20, 5, 4, 5, 2017, 7
insert workhours select 20, 5, 5, 5, 2017, 8
insert workhours select 20, 5, 8, 5, 2017, 8
insert workhours select 20, 5, 9, 5, 2017, 8
insert workhours select 20, 5, 10, 5, 2017, 8
insert workhours select 20, 5, 11, 5, 2017, 9
insert workhours select 20, 5, 12, 5, 2017, 9
insert workhours select 20, 5, 15, 5, 2017, 9
insert workhours select 20, 5, 16, 5, 2017, 10
insert workhours select 20, 5, 17, 5, 2017, 9
insert workhours select 20, 5, 18, 5, 2017, 9
insert workhours select 20, 5, 19, 5, 2017, 9
insert workhours select 20, 5, 22, 5, 2017, 8
insert workhours select 20, 5, 23, 5, 2017, 8
insert workhours select 20, 5, 24, 5, 2017, 8
insert workhours select 20, 5, 25, 5, 2017, 8
insert workhours select 20, 5, 26, 5, 2017, 8
insert workhours select 20, 5, 29, 5, 2017, 7
insert workhours select 20, 5, 30, 5, 2017, 10
insert workhours select 20, 5, 31, 5, 2017, 10
insert workhours select 20, 5, 1, 6, 2017, 10
insert workhours select 20, 5, 2, 6, 2017, 9
insert workhours select 20, 5, 5, 6, 2017, 8
insert workhours select 20, 5, 6, 6, 2017, 8
insert workhours select 20, 5, 7, 6, 2017, 8
insert workhours select 20, 5, 8, 6, 2017, 8
insert workhours select 20, 5, 9, 6, 2017, 8
insert workhours select 20, 5, 12, 6, 2017, 8
insert workhours select 20, 5, 13, 6, 2017, 8
insert workhours select 20, 5, 14, 6, 2017, 8
insert workhours select 20, 5, 15, 6, 2017, 8
insert workhours select 20, 5, 16, 6, 2017, 8
insert workhours select 20, 5, 19, 6, 2017, 9
insert workhours select 20, 5, 20, 6, 2017, 9
insert workhours select 20, 5, 21, 6, 2017, 9
insert workhours select 20, 5, 22, 6, 2017, 9
insert workhours select 20, 5, 23, 6, 2017, 10
insert workhours select 20, 5, 26, 6, 2017, 10
insert workhours select 20, 5, 27, 6, 2017, 10
insert workhours select 20, 5, 28, 6, 2017, 10
insert workhours select 20, 5, 29, 6, 2017, 11
insert workhours select 20, 5, 30, 6, 2017, 8
insert workhours select 20, 5, 3, 7, 2017, 8
insert workhours select 20, 5, 4, 7, 2017, 8
insert workhours select 20, 5, 5, 7, 2017, 8
insert workhours select 20, 5, 6, 7, 2017, 7
insert workhours select 20, 5, 7, 7, 2017, 5
insert workhours select 20, 5, 10, 7, 2017, 10
insert workhours select 20, 5, 11, 7, 2017, 10
insert workhours select 20, 5, 12, 7, 2017, 10
insert workhours select 20, 5, 13, 7, 2017, 8
insert workhours select 20, 5, 14, 7, 2017, 7
insert workhours select 20, 5, 17, 7, 2017, 8
insert workhours select 20, 5, 18, 7, 2017, 8
insert workhours select 20, 5, 19, 7, 2017, 9
insert workhours select 20, 5, 20, 7, 2017, 9
insert workhours select 20, 5, 21, 7, 2017, 9
insert workhours select 20, 5, 24, 7, 2017, 9
insert workhours select 20, 5, 25, 7, 2017, 9
insert workhours select 20, 5, 26, 7, 2017, 9
insert workhours select 20, 5, 27, 7, 2017, 9
insert workhours select 20, 5, 28, 7, 2017, 8
insert workhours select 20, 5, 31, 7, 2017, 10
insert workhours select 20, 10, 20, 2, 2017, 6
insert workhours select 20, 10, 21, 2, 2017, 6
insert workhours select 20, 10, 22, 2, 2017, 7
insert workhours select 20, 10, 23, 2, 2017, 8
insert workhours select 20, 10, 24, 2, 2017, 8
insert workhours select 20, 10, 27, 2, 2017, 8
insert workhours select 20, 10, 28, 2, 2017, 8
insert workhours select 20, 10, 1, 3, 2017, 8
insert workhours select 20, 10, 2, 3, 2017, 8
insert workhours select 20, 10, 3, 3, 2017, 8
insert workhours select 20, 10, 6, 3, 2017, 8
insert workhours select 20, 10, 7, 3, 2017, 7
insert workhours select 20, 10, 8, 3, 2017, 7
insert workhours select 20, 10, 9, 3, 2017, 9
insert workhours select 20, 10, 10, 3, 2017, 9
insert workhours select 20, 10, 13, 3, 2017, 9
insert workhours select 20, 10, 14, 3, 2017, 9
insert workhours select 20, 10, 15, 3, 2017, 9
insert workhours select 20, 10, 16, 3, 2017, 9
insert workhours select 20, 10, 17, 3, 2017, 10
insert workhours select 20, 10, 20, 3, 2017, 10
insert workhours select 20, 10, 21, 3, 2017, 10
insert workhours select 20, 10, 22, 3, 2017, 10
insert workhours select 20, 10, 23, 3, 2017, 10
insert workhours select 20, 10, 24, 3, 2017, 10
insert workhours select 20, 10, 27, 3, 2017, 10
insert workhours select 20, 10, 28, 3, 2017, 10
insert workhours select 20, 10, 29, 3, 2017, 9
insert workhours select 20, 10, 30, 3, 2017, 9
insert workhours select 20, 10, 31, 3, 2017, 9
insert workhours select 20, 10, 3, 4, 2017, 9
insert workhours select 20, 10, 4, 4, 2017, 9
insert workhours select 20, 10, 5, 4, 2017, 9
insert workhours select 20, 10, 6, 4, 2017, 9
insert workhours select 20, 10, 7, 4, 2017, 6
insert workhours select 20, 10, 10, 4, 2017, 7
insert workhours select 20, 10, 11, 4, 2017, 8
insert workhours select 20, 10, 12, 4, 2017, 8
insert workhours select 20, 10, 13, 4, 2017, 8
insert workhours select 20, 10, 14, 4, 2017, 8
insert workhours select 20, 10, 17, 4, 2017, 9
insert workhours select 20, 10, 18, 4, 2017, 9
insert workhours select 20, 10, 19, 4, 2017, 9
insert workhours select 20, 10, 20, 4, 2017, 10
insert workhours select 20, 10, 21, 4, 2017, 8
insert workhours select 20, 10, 24, 4, 2017, 8
insert workhours select 20, 10, 25, 4, 2017, 8
insert workhours select 20, 10, 26, 4, 2017, 8
insert workhours select 20, 10, 27, 4, 2017, 8
insert workhours select 20, 10, 28, 4, 2017, 7
insert workhours select 20, 10, 1, 5, 2017, 10
insert workhours select 20, 10, 2, 5, 2017, 10
insert workhours select 20, 10, 3, 5, 2017, 10
insert workhours select 20, 10, 4, 5, 2017, 9
insert workhours select 20, 10, 5, 5, 2017, 8
insert workhours select 20, 10, 8, 5, 2017, 8
insert workhours select 20, 10, 9, 5, 2017, 8
insert workhours select 20, 10, 10, 5, 2017, 8
insert workhours select 20, 10, 11, 5, 2017, 8
insert workhours select 20, 10, 12, 5, 2017, 8
insert workhours select 20, 10, 15, 5, 2017, 8
insert workhours select 20, 10, 16, 5, 2017, 8
insert workhours select 20, 10, 17, 5, 2017, 8
insert workhours select 20, 10, 18, 5, 2017, 8
insert workhours select 20, 10, 19, 5, 2017, 9
insert workhours select 20, 10, 22, 5, 2017, 9
insert workhours select 20, 10, 23, 5, 2017, 9
insert workhours select 20, 10, 24, 5, 2017, 9
insert workhours select 20, 10, 25, 5, 2017, 10
insert workhours select 20, 10, 26, 5, 2017, 10
insert workhours select 20, 10, 29, 5, 2017, 10
insert workhours select 20, 10, 30, 5, 2017, 10
insert workhours select 20, 10, 31, 5, 2017, 11
insert workhours select 20, 10, 1, 6, 2017, 8
insert workhours select 20, 10, 2, 6, 2017, 8
insert workhours select 20, 10, 5, 6, 2017, 8
insert workhours select 20, 10, 6, 6, 2017, 8
insert workhours select 20, 10, 7, 6, 2017, 7
insert workhours select 20, 10, 8, 6, 2017, 5
insert workhours select 20, 10, 9, 6, 2017, 10
insert workhours select 20, 10, 12, 6, 2017, 10
insert workhours select 20, 10, 13, 6, 2017, 10
insert workhours select 20, 10, 14, 6, 2017, 8
insert workhours select 20, 10, 15, 6, 2017, 7
insert workhours select 20, 10, 16, 6, 2017, 8
insert workhours select 20, 10, 19, 6, 2017, 8
insert workhours select 20, 10, 20, 6, 2017, 9
insert workhours select 20, 10, 21, 6, 2017, 9
insert workhours select 20, 10, 22, 6, 2017, 9
insert workhours select 20, 10, 23, 6, 2017, 9
insert workhours select 20, 10, 26, 6, 2017, 9
insert workhours select 20, 10, 27, 6, 2017, 9
insert workhours select 20, 10, 28, 6, 2017, 9
insert workhours select 20, 10, 29, 6, 2017, 8
insert workhours select 20, 10, 30, 6, 2017, 10
insert workhours select 20, 10, 3, 7, 2017, 6
insert workhours select 20, 10, 4, 7, 2017, 6
insert workhours select 20, 10, 5, 7, 2017, 7
insert workhours select 20, 10, 6, 7, 2017, 8
insert workhours select 20, 10, 7, 7, 2017, 8
insert workhours select 20, 10, 10, 7, 2017, 8
insert workhours select 20, 10, 11, 7, 2017, 8
insert workhours select 20, 10, 12, 7, 2017, 8
insert workhours select 20, 10, 13, 7, 2017, 8
insert workhours select 20, 10, 14, 7, 2017, 8
insert workhours select 20, 10, 17, 7, 2017, 8
insert workhours select 20, 10, 18, 7, 2017, 7
insert workhours select 20, 10, 19, 7, 2017, 7
insert workhours select 20, 10, 20, 7, 2017, 9
insert workhours select 20, 10, 21, 7, 2017, 9
insert workhours select 20, 10, 24, 7, 2017, 9
insert workhours select 20, 10, 25, 7, 2017, 9
insert workhours select 20, 10, 26, 7, 2017, 9
insert workhours select 20, 10, 27, 7, 2017, 9
insert workhours select 20, 10, 28, 7, 2017, 10
insert workhours select 20, 10, 31, 7, 2017, 10
insert workhours select 21, 3, 15, 8, 2016, 10
insert workhours select 21, 3, 16, 8, 2016, 10
insert workhours select 21, 3, 17, 8, 2016, 10
insert workhours select 21, 3, 18, 8, 2016, 10
insert workhours select 21, 3, 19, 8, 2016, 10
insert workhours select 21, 3, 22, 8, 2016, 10
insert workhours select 21, 3, 23, 8, 2016, 9
insert workhours select 21, 3, 24, 8, 2016, 9
insert workhours select 21, 3, 25, 8, 2016, 9
insert workhours select 21, 3, 26, 8, 2016, 9
insert workhours select 21, 3, 29, 8, 2016, 9
insert workhours select 21, 3, 30, 8, 2016, 9
insert workhours select 21, 3, 31, 8, 2016, 9
insert workhours select 21, 3, 1, 9, 2016, 6
insert workhours select 21, 3, 2, 9, 2016, 7
insert workhours select 21, 3, 5, 9, 2016, 8
insert workhours select 21, 3, 6, 9, 2016, 8
insert workhours select 21, 3, 7, 9, 2016, 8
insert workhours select 21, 3, 8, 9, 2016, 8
insert workhours select 21, 3, 9, 9, 2016, 9
insert workhours select 21, 3, 12, 9, 2016, 9
insert workhours select 21, 3, 13, 9, 2016, 9
insert workhours select 21, 3, 14, 9, 2016, 10
insert workhours select 21, 3, 15, 9, 2016, 9
insert workhours select 21, 3, 16, 9, 2016, 9
insert workhours select 21, 3, 19, 9, 2016, 9
insert workhours select 21, 3, 20, 9, 2016, 8
insert workhours select 21, 3, 21, 9, 2016, 8
insert workhours select 21, 3, 22, 9, 2016, 8
insert workhours select 21, 3, 23, 9, 2016, 8
insert workhours select 21, 3, 26, 9, 2016, 8
insert workhours select 21, 3, 27, 9, 2016, 8
insert workhours select 21, 3, 28, 9, 2016, 8
insert workhours select 21, 3, 29, 9, 2016, 8
insert workhours select 21, 3, 30, 9, 2016, 8
insert workhours select 21, 3, 3, 10, 2016, 8
insert workhours select 21, 3, 4, 10, 2016, 8
insert workhours select 21, 3, 5, 10, 2016, 8
insert workhours select 21, 3, 6, 10, 2016, 7
insert workhours select 21, 3, 7, 10, 2016, 10
insert workhours select 21, 3, 10, 10, 2016, 10
insert workhours select 21, 3, 11, 10, 2016, 10
insert workhours select 21, 3, 12, 10, 2016, 9
insert workhours select 21, 3, 13, 10, 2016, 8
insert workhours select 21, 3, 14, 10, 2016, 8
insert workhours select 21, 3, 17, 10, 2016, 8
insert workhours select 21, 3, 18, 10, 2016, 8
insert workhours select 21, 3, 19, 10, 2016, 8
insert workhours select 21, 3, 20, 10, 2016, 8
insert workhours select 21, 3, 21, 10, 2016, 8
insert workhours select 21, 3, 24, 10, 2016, 8
insert workhours select 21, 3, 25, 10, 2016, 8
insert workhours select 21, 3, 26, 10, 2016, 8
insert workhours select 21, 3, 27, 10, 2016, 9
insert workhours select 21, 3, 28, 10, 2016, 9
insert workhours select 21, 3, 31, 10, 2016, 9
insert workhours select 21, 3, 1, 11, 2016, 9
insert workhours select 21, 3, 2, 11, 2016, 10
insert workhours select 21, 3, 3, 11, 2016, 10
insert workhours select 21, 3, 4, 11, 2016, 10
insert workhours select 21, 3, 7, 11, 2016, 10
insert workhours select 21, 3, 8, 11, 2016, 11
insert workhours select 21, 3, 9, 11, 2016, 8
insert workhours select 21, 3, 10, 11, 2016, 8
insert workhours select 21, 3, 11, 11, 2016, 8
insert workhours select 21, 3, 14, 11, 2016, 8
insert workhours select 21, 3, 15, 11, 2016, 7
insert workhours select 21, 3, 16, 11, 2016, 5
insert workhours select 21, 3, 17, 11, 2016, 10
insert workhours select 21, 3, 18, 11, 2016, 10
insert workhours select 21, 3, 21, 11, 2016, 10
insert workhours select 21, 3, 22, 11, 2016, 8
insert workhours select 21, 3, 23, 11, 2016, 7
insert workhours select 21, 3, 24, 11, 2016, 8
insert workhours select 21, 3, 25, 11, 2016, 8
insert workhours select 21, 3, 28, 11, 2016, 9
insert workhours select 21, 3, 29, 11, 2016, 9
insert workhours select 21, 3, 30, 11, 2016, 9
insert workhours select 21, 3, 1, 12, 2016, 9
insert workhours select 21, 3, 2, 12, 2016, 9
insert workhours select 21, 3, 5, 12, 2016, 9
insert workhours select 21, 3, 6, 12, 2016, 9
insert workhours select 21, 3, 7, 12, 2016, 8
insert workhours select 21, 3, 8, 12, 2016, 10
insert workhours select 21, 3, 9, 12, 2016, 6
insert workhours select 21, 3, 12, 12, 2016, 6
insert workhours select 21, 3, 13, 12, 2016, 7
insert workhours select 21, 3, 14, 12, 2016, 8
insert workhours select 21, 3, 15, 12, 2016, 8
insert workhours select 21, 3, 16, 12, 2016, 8
insert workhours select 21, 3, 19, 12, 2016, 8
insert workhours select 21, 3, 20, 12, 2016, 8
insert workhours select 21, 3, 21, 12, 2016, 8
insert workhours select 21, 3, 22, 12, 2016, 8
insert workhours select 21, 3, 23, 12, 2016, 8
insert workhours select 21, 3, 26, 12, 2016, 7
insert workhours select 21, 3, 27, 12, 2016, 7
insert workhours select 21, 3, 28, 12, 2016, 9
insert workhours select 21, 3, 29, 12, 2016, 9
insert workhours select 21, 3, 30, 12, 2016, 9
insert workhours select 21, 3, 2, 1, 2017, 9
insert workhours select 21, 3, 3, 1, 2017, 9
insert workhours select 21, 3, 4, 1, 2017, 9
insert workhours select 21, 3, 5, 1, 2017, 10
insert workhours select 21, 3, 6, 1, 2017, 10
insert workhours select 21, 3, 9, 1, 2017, 10
insert workhours select 21, 3, 10, 1, 2017, 10
insert workhours select 21, 3, 11, 1, 2017, 10
insert workhours select 21, 3, 12, 1, 2017, 10
insert workhours select 21, 3, 13, 1, 2017, 10
insert workhours select 21, 3, 16, 1, 2017, 10
insert workhours select 21, 3, 17, 1, 2017, 9
insert workhours select 21, 3, 18, 1, 2017, 9
insert workhours select 21, 3, 19, 1, 2017, 9
insert workhours select 21, 3, 20, 1, 2017, 9
insert workhours select 21, 3, 23, 1, 2017, 9
insert workhours select 21, 3, 24, 1, 2017, 9
insert workhours select 21, 3, 25, 1, 2017, 9
insert workhours select 21, 3, 26, 1, 2017, 6
insert workhours select 21, 3, 27, 1, 2017, 7
insert workhours select 21, 3, 30, 1, 2017, 8
insert workhours select 21, 3, 31, 1, 2017, 8
insert workhours select 21, 3, 1, 2, 2017, 8
insert workhours select 21, 3, 2, 2, 2017, 8
insert workhours select 21, 3, 3, 2, 2017, 9
insert workhours select 21, 3, 6, 2, 2017, 9
insert workhours select 21, 3, 7, 2, 2017, 9
insert workhours select 21, 3, 8, 2, 2017, 10
insert workhours select 21, 3, 9, 2, 2017, 9
insert workhours select 21, 3, 10, 2, 2017, 9
insert workhours select 21, 3, 13, 2, 2017, 9
insert workhours select 21, 3, 14, 2, 2017, 8
insert workhours select 21, 3, 15, 2, 2017, 8
insert workhours select 21, 3, 16, 2, 2017, 8
insert workhours select 21, 3, 17, 2, 2017, 8
insert workhours select 21, 3, 20, 2, 2017, 8
insert workhours select 21, 3, 21, 2, 2017, 8
insert workhours select 21, 3, 22, 2, 2017, 8
insert workhours select 21, 3, 23, 2, 2017, 8
insert workhours select 21, 3, 24, 2, 2017, 8
insert workhours select 21, 3, 27, 2, 2017, 8
insert workhours select 21, 3, 28, 2, 2017, 8
insert workhours select 21, 3, 1, 3, 2017, 8
insert workhours select 21, 3, 2, 3, 2017, 8
insert workhours select 21, 3, 3, 3, 2017, 8
insert workhours select 21, 3, 6, 3, 2017, 8
insert workhours select 21, 3, 7, 3, 2017, 8
insert workhours select 21, 3, 8, 3, 2017, 8
insert workhours select 21, 3, 9, 3, 2017, 7
insert workhours select 21, 3, 10, 3, 2017, 10
insert workhours select 21, 3, 13, 3, 2017, 10
insert workhours select 21, 3, 14, 3, 2017, 10
insert workhours select 21, 3, 15, 3, 2017, 9
insert workhours select 21, 3, 16, 3, 2017, 8
insert workhours select 21, 3, 17, 3, 2017, 8
insert workhours select 21, 3, 20, 3, 2017, 8
insert workhours select 21, 3, 21, 3, 2017, 8
insert workhours select 21, 3, 22, 3, 2017, 8
insert workhours select 21, 3, 23, 3, 2017, 8
insert workhours select 21, 3, 24, 3, 2017, 8
insert workhours select 21, 3, 27, 3, 2017, 8
insert workhours select 21, 3, 28, 3, 2017, 8
insert workhours select 21, 3, 29, 3, 2017, 8
insert workhours select 21, 3, 30, 3, 2017, 9
insert workhours select 21, 3, 31, 3, 2017, 9
insert workhours select 21, 3, 3, 4, 2017, 9
insert workhours select 21, 3, 4, 4, 2017, 9
insert workhours select 21, 3, 5, 4, 2017, 10
insert workhours select 21, 3, 6, 4, 2017, 10
insert workhours select 21, 3, 7, 4, 2017, 10
insert workhours select 21, 3, 10, 4, 2017, 10
insert workhours select 21, 3, 11, 4, 2017, 11
insert workhours select 21, 3, 12, 4, 2017, 8
insert workhours select 21, 3, 13, 4, 2017, 8
insert workhours select 21, 3, 14, 4, 2017, 8
insert workhours select 21, 3, 17, 4, 2017, 8
insert workhours select 21, 3, 18, 4, 2017, 7
insert workhours select 21, 3, 19, 4, 2017, 5
insert workhours select 21, 3, 20, 4, 2017, 10
insert workhours select 21, 3, 21, 4, 2017, 10
insert workhours select 21, 3, 24, 4, 2017, 10
insert workhours select 21, 3, 25, 4, 2017, 8
insert workhours select 21, 3, 26, 4, 2017, 7
insert workhours select 21, 3, 27, 4, 2017, 8
insert workhours select 21, 3, 28, 4, 2017, 8
insert workhours select 21, 3, 1, 5, 2017, 9
insert workhours select 21, 3, 2, 5, 2017, 9
insert workhours select 21, 3, 3, 5, 2017, 9
insert workhours select 21, 3, 4, 5, 2017, 9
insert workhours select 21, 3, 5, 5, 2017, 9
insert workhours select 21, 3, 8, 5, 2017, 9
insert workhours select 21, 3, 9, 5, 2017, 9
insert workhours select 21, 3, 10, 5, 2017, 8
insert workhours select 21, 3, 11, 5, 2017, 10
insert workhours select 21, 3, 12, 5, 2017, 6
insert workhours select 21, 3, 15, 5, 2017, 6
insert workhours select 21, 3, 16, 5, 2017, 7
insert workhours select 21, 3, 17, 5, 2017, 8
insert workhours select 21, 3, 18, 5, 2017, 8
insert workhours select 21, 3, 19, 5, 2017, 8
insert workhours select 21, 3, 22, 5, 2017, 8
insert workhours select 21, 3, 23, 5, 2017, 8
insert workhours select 21, 3, 24, 5, 2017, 8
insert workhours select 21, 3, 25, 5, 2017, 8
insert workhours select 21, 3, 26, 5, 2017, 8
insert workhours select 21, 3, 29, 5, 2017, 7
insert workhours select 21, 3, 30, 5, 2017, 7
insert workhours select 21, 3, 31, 5, 2017, 9
insert workhours select 21, 3, 1, 6, 2017, 9
insert workhours select 21, 3, 2, 6, 2017, 9
insert workhours select 21, 3, 5, 6, 2017, 9
insert workhours select 21, 3, 6, 6, 2017, 9
insert workhours select 21, 3, 7, 6, 2017, 9
insert workhours select 21, 3, 8, 6, 2017, 10
insert workhours select 21, 3, 9, 6, 2017, 10
insert workhours select 21, 3, 12, 6, 2017, 10
insert workhours select 21, 3, 13, 6, 2017, 10
insert workhours select 21, 3, 14, 6, 2017, 10
insert workhours select 21, 3, 15, 6, 2017, 10
insert workhours select 21, 3, 16, 6, 2017, 10
insert workhours select 21, 3, 19, 6, 2017, 10
insert workhours select 21, 3, 20, 6, 2017, 9
insert workhours select 21, 3, 21, 6, 2017, 9
insert workhours select 21, 3, 22, 6, 2017, 9
insert workhours select 21, 3, 23, 6, 2017, 9
insert workhours select 21, 3, 26, 6, 2017, 9
insert workhours select 21, 3, 27, 6, 2017, 9
insert workhours select 21, 3, 28, 6, 2017, 9
insert workhours select 21, 3, 29, 6, 2017, 6
insert workhours select 21, 3, 30, 6, 2017, 7
insert workhours select 21, 3, 3, 7, 2017, 8
insert workhours select 21, 3, 4, 7, 2017, 8
insert workhours select 21, 3, 5, 7, 2017, 8
insert workhours select 21, 3, 6, 7, 2017, 8
insert workhours select 21, 3, 7, 7, 2017, 9
insert workhours select 21, 3, 10, 7, 2017, 8
insert workhours select 21, 3, 11, 7, 2017, 8
insert workhours select 21, 3, 12, 7, 2017, 8
insert workhours select 21, 3, 13, 7, 2017, 8
insert workhours select 21, 3, 14, 7, 2017, 8
insert workhours select 21, 3, 17, 7, 2017, 7
insert workhours select 21, 3, 18, 7, 2017, 10
insert workhours select 21, 3, 19, 7, 2017, 10
insert workhours select 21, 3, 20, 7, 2017, 10
insert workhours select 21, 3, 21, 7, 2017, 9
insert workhours select 21, 3, 24, 7, 2017, 8
insert workhours select 21, 3, 25, 7, 2017, 8
insert workhours select 21, 3, 26, 7, 2017, 8
insert workhours select 21, 3, 27, 7, 2017, 8
insert workhours select 21, 3, 28, 7, 2017, 8
insert workhours select 21, 3, 31, 7, 2017, 8
insert workhours select 21, 3, 1, 8, 2017, 8
insert workhours select 21, 3, 2, 8, 2017, 8
insert workhours select 21, 3, 3, 8, 2017, 8
insert workhours select 21, 3, 4, 8, 2017, 8
insert workhours select 21, 3, 7, 8, 2017, 9
insert workhours select 21, 3, 8, 8, 2017, 9
insert workhours select 21, 3, 9, 8, 2017, 9
insert workhours select 21, 3, 10, 8, 2017, 9
insert workhours select 21, 3, 11, 8, 2017, 10
insert workhours select 21, 3, 14, 8, 2017, 10
insert workhours select 21, 3, 15, 8, 2017, 10
insert workhours select 21, 3, 16, 8, 2017, 10
insert workhours select 21, 3, 17, 8, 2017, 11
insert workhours select 21, 3, 18, 8, 2017, 8
insert workhours select 21, 3, 21, 8, 2017, 8
insert workhours select 21, 3, 22, 8, 2017, 8
insert workhours select 21, 3, 23, 8, 2017, 8
insert workhours select 21, 3, 24, 8, 2017, 7
insert workhours select 21, 3, 25, 8, 2017, 5
insert workhours select 21, 3, 28, 8, 2017, 10
insert workhours select 21, 3, 29, 8, 2017, 10
insert workhours select 21, 3, 30, 8, 2017, 10
insert workhours select 21, 3, 31, 8, 2017, 8
insert workhours select 21, 3, 1, 9, 2017, 7
insert workhours select 21, 3, 4, 9, 2017, 8
insert workhours select 21, 3, 5, 9, 2017, 8
insert workhours select 21, 3, 6, 9, 2017, 9
insert workhours select 21, 3, 7, 9, 2017, 9
insert workhours select 21, 3, 8, 9, 2017, 9
insert workhours select 21, 3, 11, 9, 2017, 9
insert workhours select 21, 3, 12, 9, 2017, 9
insert workhours select 21, 3, 13, 9, 2017, 9
insert workhours select 21, 3, 14, 9, 2017, 9
insert workhours select 21, 3, 15, 9, 2017, 8
insert workhours select 21, 3, 18, 9, 2017, 10
insert workhours select 21, 3, 19, 9, 2017, 6
insert workhours select 21, 3, 20, 9, 2017, 6
insert workhours select 21, 3, 21, 9, 2017, 7
insert workhours select 21, 3, 22, 9, 2017, 8
insert workhours select 21, 3, 25, 9, 2017, 8
insert workhours select 21, 3, 26, 9, 2017, 8
insert workhours select 21, 3, 27, 9, 2017, 8
insert workhours select 21, 3, 28, 9, 2017, 8
insert workhours select 21, 3, 29, 9, 2017, 8
insert workhours select 22, 4, 1, 8, 2017, 8
insert workhours select 22, 4, 2, 8, 2017, 8
insert workhours select 22, 4, 3, 8, 2017, 7
insert workhours select 22, 4, 4, 8, 2017, 7
insert workhours select 22, 4, 7, 8, 2017, 9
insert workhours select 22, 4, 8, 8, 2017, 9
insert workhours select 22, 4, 9, 8, 2017, 9
insert workhours select 22, 4, 10, 8, 2017, 9
insert workhours select 22, 4, 11, 8, 2017, 9
insert workhours select 22, 4, 14, 8, 2017, 9
insert workhours select 22, 4, 15, 8, 2017, 10
insert workhours select 22, 4, 16, 8, 2017, 10
insert workhours select 22, 4, 17, 8, 2017, 10
insert workhours select 22, 4, 18, 8, 2017, 10
insert workhours select 22, 4, 21, 8, 2017, 10
insert workhours select 22, 4, 22, 8, 2017, 10
insert workhours select 22, 4, 23, 8, 2017, 10
insert workhours select 22, 4, 24, 8, 2017, 10
insert workhours select 22, 4, 25, 8, 2017, 9
insert workhours select 22, 4, 28, 8, 2017, 9
insert workhours select 22, 4, 29, 8, 2017, 9
insert workhours select 22, 4, 30, 8, 2017, 9
insert workhours select 22, 4, 31, 8, 2017, 9
insert workhours select 23, 5, 1, 9, 2017, 9
insert workhours select 23, 5, 4, 9, 2017, 9
insert workhours select 23, 5, 5, 9, 2017, 6
insert workhours select 23, 5, 6, 9, 2017, 7
insert workhours select 23, 5, 7, 9, 2017, 8
insert workhours select 23, 5, 8, 9, 2017, 8
insert workhours select 23, 5, 11, 9, 2017, 8
insert workhours select 23, 5, 12, 9, 2017, 8
insert workhours select 23, 5, 13, 9, 2017, 9
insert workhours select 23, 5, 14, 9, 2017, 9
insert workhours select 23, 5, 15, 9, 2017, 9
insert workhours select 23, 5, 18, 9, 2017, 10
insert workhours select 23, 5, 19, 9, 2017, 9
insert workhours select 23, 5, 20, 9, 2017, 9
insert workhours select 23, 5, 21, 9, 2017, 9
insert workhours select 23, 5, 22, 9, 2017, 8
insert workhours select 23, 5, 25, 9, 2017, 8
insert workhours select 23, 5, 26, 9, 2017, 8
insert workhours select 23, 5, 27, 9, 2017, 8
insert workhours select 23, 5, 28, 9, 2017, 8
insert workhours select 23, 5, 29, 9, 2017, 8
insert workhours select 23, 5, 30, 9, 2017, 8

go

select * from Clients
select * from Contracts
select * from ContractTypes
select * from Countries
select * from EmployeeProjectAssignments
select * from Employees
select * from Offices
select * from Projects
select * from Regions
select * from WorkHours

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




