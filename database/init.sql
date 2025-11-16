

-- CREATE TABLE IF NOT EXISTS users (
--     id SERIAL PRIMARY KEY,
--     username VARCHAR(50) NOT NULL UNIQUE,
--     email VARCHAR(100)
-- );

CREATE TABLE IF NOT EXISTS users (
  
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100)

);

INSERT INTO users VALUES 
(1,"red-coder",20,"git-street"),
(2,"green-coder",30,"git-HQ"),
(3,"grey-coder",40,"git-house");
