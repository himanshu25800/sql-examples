
select COUNT(*) from email_data

SELECT * from email_data

select MAX(id) from email_data  -- max 496


INSERT into email_data(id, post_id, name, email, body) VALUES
(497 , 54, 'Himanshu', 'himanshu@gmail.com', 'Hey this tuple is added to test if db is in sync or not')

update email_data set id=499 where id =28

truncate table email_data

drop table email_data


CREATE TABLE email_data (
    id INT PRIMARY KEY,  -- Replaced SERIAL with IDENTITY
    post_id INT,
    name NVARCHAR(MAX) NOT NULL,  -- Changed TEXT to NVARCHAR(MAX) for SQL Server
    email NVARCHAR(255) NOT NULL, -- Changed VARCHAR to NVARCHAR for Unicode support
    body NVARCHAR(MAX) NOT NULL   -- Changed TEXT to NVARCHAR(MAX) for SQL Server
);

