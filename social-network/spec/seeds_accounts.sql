TRUNCATE TABLE accounts RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (username, email) VALUES ('username1', 'username1@fakeemail.com');
INSERT INTO accounts (username, email) VALUES ('username2', 'username2@fakeemail.com');
