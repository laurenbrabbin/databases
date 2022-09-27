You should create a new database movies_directory for this exercise.

## Infer the table schema from these user stories.

As a person who loves movies,
So I can list all my favourite movies
I want to see a list of movies' titles.

As a person who loves movies,
So I can list all my favourite movies
I want to see a list of movies' genres.

As a person who loves movies,
So I can list all my favourite movies
I want to see a list of movies' release year.

## Steps

1. Copy the Design Recipe template and use it to design the schema for that table.
2. Create the table by loading the SQL table file in psql.
3. To verify your work, make sure to run an INSERT query to insert a new movie record, and then a SELECT query to list the records.

## Verifying...

psql -h 127.0.0.1 movies_directory

INSERT INTO movies (title, genre, release_year) VALUES('Batman', 'action', '2022');

SELECT id, title, genre, release_year FROM movies;