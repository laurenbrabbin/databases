TRUNCATE TABLE posts RESTART IDENTITY CASCADE;
TRUNCATE TABLE comments RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content) VALUES('Monday', 'I went to the shop');
INSERT INTO posts (title, content) VALUES('Tuesday', 'I went to the swimming pool');
INSERT INTO posts (title, content) VALUES('Wednesday', 'I went to the park');


INSERT INTO comments (author, content, post_id) VALUES('emily', 'wish I was there', 1);
INSERT INTO comments (author, content, post_id) VALUES('lauren', 'that sounds fun', 2);
INSERT INTO comments (author, content, post_id) VALUES('tom', 'have fun', 3);
INSERT INTO comments (author, content, post_id) VALUES('abbi', 'yay', 1);
INSERT INTO comments (author, content, post_id) VALUES('person', 'hello', 2);

