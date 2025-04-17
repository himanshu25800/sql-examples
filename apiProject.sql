DROP FUNCTION insertindb(integer,character varying,character varying,character varying,date,character varying,character varying,character varying)


CREATE OR REPLACE FUNCTION insertindb(
	empid integer,
	firstname varchar(20),
	lastname varchar(20),
	city varchar(20),
	dateofbirth date,
	phonenumber varchar(20),
	email varchar(20),
	gender varchar(20),
	userPassword varchar(200)
)
    RETURNS TEXT
AS $$
DECLARE
    existing_count INT;
    email_count INT;
	 phonenumber_count INT;
BEGIN

    SELECT COUNT(*) INTO existing_count FROM employee as e WHERE e.employeeid = insertindb.empid;
    IF existing_count > 0 THEN
        RETURN json_build_object('message','Employee ID ' || insertindb.empid || ' already exists', 'status', False)::json;
    END IF;

    SELECT COUNT(*) INTO email_count FROM employee as e WHERE e.email = insertindb.email;
    IF email_count > 0 THEN
        RETURN json_build_object('message','Email ' || insertindb.email || ' already exists', 'status', False)::json;
		
    END IF;
	SELECT COUNT(*) INTO phonenumber_count FROM employee as e
	WHERE e.phonenumber = insertindb.phonenumber and e.employeeId != insertindb.empId;
    IF phonenumber_count > 0 THEN
        RETURN json_build_object('message','Phone Number ' || phonenumber || ' already exists', 'status', False)::json;
		
    END IF;

	INSERT INTO employee (employeeid, firstname, lastname, city, dateofbirth, phonenumber, email, gender, userPassword)
	VALUES (insertindb.empid, insertindb.firstname, insertindb.lastname, insertindb.city, 
	        insertindb.dateofbirth, insertindb.phonenumber, insertindb.email, insertindb.gender, insertindb.userPassword)
	ON CONFLICT ("employeeid") DO NOTHING;

    RETURN json_build_object('message', 'Employee ' || insertindb.empId || ' inserted successfully', 'status', True)::json;
END;
$$ LANGUAGE plpgsql;


select * from employee;

SELECT insertindb(
    113, 
    'Harsh', 
    'Chauhan', 
    'Greater Noida', 
    '1999-01-23'::DATE, 
    '1234567890', 
    'harsh@email.com', 
    'Male',
	'12345678'
);




 DROP FUNCTION updateindb(integer,character varying,character varying,character varying,date,character varying,character varying,character varying)



CREATE OR REPLACE FUNCTION updateindb(
	employeeid INTEGER,
	firstname VARCHAR(20),
	lastname VARCHAR(20),
	city VARCHAR(20),
	dateofbirth DATE,
	phonenumber VARCHAR(20),
	email VARCHAR(20),
	gender VARCHAR(20),
	userPassword VARCHAR(200)
) RETURNS JSON AS $$
DECLARE
    existing_count INT;
    email_count INT;
	phonenumber_count INT;
BEGIN
    SELECT COUNT(*) INTO existing_count FROM employee WHERE employee.employeeid = updateindb.employeeid;
    IF existing_count = 0 THEN
        RETURN  json_build_object('message','Employee ID ' || updateindb.employeeid || ' does not exist', 'status', False);
    END IF;

    SELECT COUNT(*) INTO email_count FROM employee 
    WHERE employee.email = updateindb.email 
      AND employee.employeeid != updateindb.employeeid;
    IF email_count > 0 THEN
        RETURN json_build_object('message','Email ' || updateindb.email || ' already exists', 'status', False);
    END IF;

	SELECT COUNT(*) INTO phonenumber_count FROM employee 
    WHERE employee.phonenumber = updateindb.phonenumber 
      AND employee.employeeid != updateindb.employeeid;
    IF phonenumber_count > 0 THEN
        RETURN json_build_object('message','Phone Number ' || updateindb.phonenumber || ' already exists', 'status', False);
    END IF;

	UPDATE employee
	SET firstname = updateindb.firstname, 
	    lastname = updateindb.lastname,
	    city = updateindb.city,
	    dateofbirth = updateindb.dateofbirth, 
	    phonenumber = updateindb.phonenumber,
	    email = updateindb.email,
	    gender = updateindb.gender,
		userPassword = updateindb.userPassword
	WHERE employee.employeeid = updateindb.employeeid;

    RETURN json_build_object('message','Employee ' || updateindb.employeeid || ' updated successfully', 'status', True);
END;
$$ LANGUAGE plpgsql;


select * from employee

   
SELECT updateindb(
     113, 
     'Harsh', 
     'Singh', 
     'Greater Noida', 
     '1999-01-23'::DATE, 
     '9820455870', 
     'harsh1@email.com', 
     'Male',
	 '12345678'
 );


 select * from employee


alter table employee 
add column userPassword varchar(10) default '12345678',
add constraint check_length check (length(userPassword)>=8);


create or replace function getList(managerId int) 
RETURNS JSON as $$
	DECLARE
	json_result JSON;
	BEGIN
		 WITH RECURSIVE manages AS (
		 
        -- base case
        SELECT employeeId
        FROM employeeDepartment as ed 
        WHERE ed.managerId = getList.managerId
        
        UNION ALL
        
        -- Recursive case
        SELECT 
            ed.employeeId
        FROM 
            employeeDepartment as ed
        INNER JOIN
            manages m ON ed.managerId = m.employeeId
    )

		SELECT json_agg(row_to_json(e)) INTO json_result
		FROM employee as e 
		inner join manages
		on e.employeeId = manages.employeeId;

		Return json_result;
	END;
$$ Language plpgsql;

select getList(102)


DROP FUNCTION getlist(integer)

Insert into employeeDepartment(employeeId, departmentId, post, managerId) values 
(110,1,'Trainee',101),
(111,1,'Trainee',101),
(112,1,'Trainee',101);


select * from employeeDepartment
select * from employee


UPDATE employee 
SET userpassword = '$2b$12$.x8l4k4OulN4FQ4uovysnOJFzuUiD0yzSNEDB7y0dm2LXOilmW.7u'