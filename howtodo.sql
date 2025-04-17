create or replace function tableStatus (varchar(20))
returns boolean
as $$
begin
	raise notice 'In get Table status';
	if exists(select 1 from information_schema.tables 
	where table_schema='public' and table_name=$1 ) then 
		raise notice 'Table already exists';
		return false;
	end if;
	return True;
end $$ language plpgsql




CREATE OR REPLACE FUNCTION average_salary_by_department(department_id INT) 
RETURNS DECIMAL AS $$
	BEGIN
		select avg(salary)
		from salaries 
		where employeeId in(
			select employeeId
			from employeedepartment
			where departmentId = department_id
			)
	END;
$$ LANGUAGE plpgsql;




select average_salary_by_department(2)


select * from employee;

select * from departments;

select * from employeeDepartment;

select * from salaries;

