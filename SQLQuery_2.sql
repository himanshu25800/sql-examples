create Table email_data(
    id INT  PRIMARY KEY,
    post_id INT,
    name TEXT NOT NULL,
    email VARCHAR(255) NOT NULL,
    body TEXT NOT NULL  
);


CREATE TABLE email_data (
    id INT PRIMARY KEY,  -- Replaced SERIAL with IDENTITY
    post_id INT,
    name NVARCHAR(MAX) NOT NULL,  -- Changed TEXT to NVARCHAR(MAX) for SQL Server
    email NVARCHAR(255) NOT NULL, -- Changed VARCHAR to NVARCHAR for Unicode support
    body NVARCHAR(MAX) NOT NULL   -- Changed TEXT to NVARCHAR(MAX) for SQL Server
);

select * from email_data where id = 499


