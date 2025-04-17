create Table email_data(
    id INT  PRIMARY KEY,
    post_id INT,
    name TEXT NOT NULL,
    email VARCHAR(255) NOT NULL,
    body TEXT NOT NULL  
);


drop table email_data

select * from email_data