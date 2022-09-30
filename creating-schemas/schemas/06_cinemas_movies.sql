-- Create the first table.
CREATE TABLE cinemas (
  id SERIAL PRIMARY KEY,
  city text
);

-- Create the second table.
CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  title text,
  release_date numeric
);

-- Create the join table.
CREATE TABLE cinemas_movies (
  cinema_id int,
  movie_id int,
  constraint fk_post foreign key(cinema_id) references cinemas(id) on delete cascade,
  constraint fk_tag foreign key(movie_id) references movies(id) on delete cascade,
  PRIMARY KEY (cinema_id, movie_id)
);