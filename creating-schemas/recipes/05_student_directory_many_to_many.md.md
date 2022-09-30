## Two Tables (Many-to-Many) Design Recipe Template

Copy this recipe template to design and create two related database tables having a Many-to-Many relationship.

## 1. Extract nouns from the user stories or specification

# EXAMPLE USER STORIES:

As a coach
So I can get to know all students
I want to keep a list of students' names.

As a coach
So I can get to know all students
I want to assign tags to students (for example, "happy", "excited", etc).

As a coach
So I can get to know all students
I want to be able to assign the same tag to many different students.

As a coach
So I can get to know all students
I want to be able to assign many different tags to a student.

Nouns:
students, names, tags


## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

  Record   |  Properties
------------------------
  students | name
  tags     | title


1. Name of the first table (always plural): students
    Column names: name

2. Name of the second table (always plural): tags
    Column names: title

## 3. Decide the column types.
Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: students
id: SERIAL
name: text

Table: tags
id: SERIAL
title: text

## 4. Design the Many-to-Many relationship
Make sure you can answer YES to these two questions:

Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

# EXAMPLE

  1. Can one tag have many students? YES
  2. Can one student have many tags? YES

If you would answer "No" to one of these questions, you'll probably have to implement a One-to-Many relationship, which is simpler. Use the relevant design recipe in that case.

## 5. Design the Join Table
The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is table1_table2.

# EXAMPLE

Join table for tables: students and tags

Join table name: students_tags

Columns: student_id, tag_id

## 4. Write the SQL.
-- EXAMPLE
-- file: students_tags.sql

-- Replace the table name, columm names and types.

-- Create the first table.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text
);

-- Create the second table.
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  title text
);

-- Create the join table.
CREATE TABLE student_tags (
  student_id int,
  tag_id int,
  constraint fk_post foreign key(post_id) references posts(id) on delete cascade,
  constraint fk_tag foreign key(tag_id) references tags(id) on delete cascade,
  PRIMARY KEY (post_id, tag_id)
);

5. Create the tables.
psql -h 127.0.0.1 database_name < posts_tags.sql
