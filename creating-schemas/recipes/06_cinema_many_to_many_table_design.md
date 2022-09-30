## Two Tables (Many-to-Many) Design Recipe Template

Copy this recipe template to design and create two related database tables having a Many-to-Many relationship.

## 1. Extract nouns from the user stories or specification

# EXAMPLE USER STORIES:

As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of movies with their title and release date.

As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of my cinemas with their city name (e.g 'London' or 'Manchester').

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which cinemas are showing a specific movie.

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which movies are being shown a specific cinema.

Nouns:
cinemas: city_name, movies
movies: title, release date, cinemas



## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

  Record   | Properties
----------------------------------------
  cinemas  | city_name, movies
  movies   | title, release date, cinema


1. Name of the first table (always plural): cinemas
    Column names: city_name, movies

2. Name of the second table (always plural): movies
    Column names: title, release date, cinema

## 3. Decide the column types.
Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: cinemas
id: SERIAL
city: text


Table: movies
id: SERIAL
title: text
release_date: numeric


## 4. Design the Many-to-Many relationship
Make sure you can answer YES to these two questions:

Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

# EXAMPLE

  1. Can one cinema have many movies? YES
  2. Can one movie have many cinemas? YES

If you would answer "No" to one of these questions, you'll probably have to implement a One-to-Many relationship, which is simpler. Use the relevant design recipe in that case.

## 5. Design the Join Table
The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is table1_table2.

# EXAMPLE

Join table for tables: cinemas and movies

Join table name: cinemas_movies

Columns: cinema_id, movie_id

## 4. Write the SQL.
-- EXAMPLE
-- file: posts_tags.sql

-- Replace the table name, columm names and types.

```sql
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
```

## 5. Create the tables.

psql -h 127.0.0.1 cinemas < 06_cinemas_movies.sql
