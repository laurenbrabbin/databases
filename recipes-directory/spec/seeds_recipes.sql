TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (id, name, cooking_time, rating) VALUES ('1', 'pizza', '1', '4');
INSERT INTO recipes (id, name, cooking_time, rating) VALUES ('2', 'pasta', '1', '3');
