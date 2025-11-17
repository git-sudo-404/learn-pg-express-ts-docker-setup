

-- CREATE TABLE IF NOT EXISTS users (
--     id SERIAL PRIMARY KEY,
--     username VARCHAR(50) NOT NULL UNIQUE,
--     email VARCHAR(100)
-- );

CREATE TABLE IF NOT EXISTS users (
  
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT ,
    email VARCHAR(100)

);

INSERT INTO users VALUES 
(1,'red-coder',20,'git-street'),
(2,'green-coder',3,'git-HQ'),
(3,'grey-code',4,'git-house'),
(4,'blue-coder',5,'git-mansion');
