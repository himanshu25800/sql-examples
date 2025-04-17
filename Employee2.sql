

-- Employee  Schema
create table Employee (
employeeId int primary key,
firstName varchar(50) not null,
lastName varchar(50),
city varchar(50) default 'Noida',
dateOfBirth Date,
phoneNumber varchar(15) check (char_length(phoneNumber)>=10)
);


-- employee department schema
-- Employee Department Schema
create table employeeDepartment (
employeeId int ,
departmentId int,
post varchar(50),
managerId int,
constraint fk_employee foreign key(employeeId) references Employee(employeeId),
constraint fk_department foreign key (departmentId) references Departments(departmentId),
constraint fk_managerId foreign key (managerId) references Employee(employeeId)
);



-- Salary Schema 
create table salaries(
employeeId int,
salary int,
constraint fk_employee foreign key (employeeId) references Employee(employeeID),
constraint chkSalary  check (salary>0)
);




create Table Departments (
departmentId int primary key, 
departmentName varchar(50)
)



select * from employee







 SELECT *
        FROM (
            (
                employee AS e
                INNER JOIN employeeDepartment AS ed ON e.employeeId = ed.employeeId
            ) AS emp_dept
            INNER JOIN salaries AS s ON s.employeeId = emp_dept.employeeId
        ) AS emp_dept_salary
        INNER JOIN departments AS d ON d.departmentId = emp_dept_salary.departmentId;



SELECT 
    e.employeeId AS emp_id,
    e.firstName,
    e.lastName,
    e.city,
    e.dateOfBirth,
    e.phoneNumber,
    ed.departmentId,
    ed.post,
    ed.managerId,
    s.salary,
    d.departmentName
FROM employee AS e
INNER JOIN employeeDepartment AS ed ON e.employeeId = ed.employeeId
INNER JOIN salaries AS s ON s.employeeId = e.employeeId
INNER JOIN departments AS d ON d.departmentId = ed.departmentId;
