TRUNCATE TABLE posts RESTART IDENTITY CASCADE; -- replace with your own table name.
TRUNCATE TABLE tags RESTART IDENTITY CASCADE;
TRUNCATE TABLE posts_tags RESTART IDENTITY CASCADE;


INSERT INTO posts (title) VALUES('How to use Git');
INSERT INTO posts (title) VALUES('Ruby classes');
INSERT INTO posts (title) VALUES('Using IRB');

INSERT INTO tags (name) VALUES('coding');
INSERT INTO tags (name) VALUES('travel');
INSERT INTO tags (name) VALUES('ruby');

INSERT INTO posts_tags (post_id, tag_id) VALUES(1, 1);
INSERT INTO posts_tags (post_id, tag_id ) VALUES(2, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES(3, 1);