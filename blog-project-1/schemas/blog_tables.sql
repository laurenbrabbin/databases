CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
);

-- Then the table with the foreign key first.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  author text,
  content text,
-- The foreign key name is always {other_table_singular}_id
  post_id int,
  constraint fk_artist foreign key(post_id)
    references posts(id)
    on delete cascade
);