-- database: student_directory_2

CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  start_date text
);

-- Then the table with the foreign key first.
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text,
-- The foreign key name is always {other_table_singular}_id
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id) 
    references cohorts(id)
    on delete cascade -- when a cohort is deleted we automatically configure to the database to also delete the student this is done on the 'delete cascade'
);