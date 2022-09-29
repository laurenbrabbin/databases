TRUNCATE TABLE cohorts RESTART IDENTITY CASCADE; -- replace with your own table name.
TRUNCATE TABLE students RESTART IDENTITY CASCADE;
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO cohorts (name, start_date) VALUES('Cohort1', 'Janurary');
INSERT INTO cohorts (name, start_date) VALUES('Cohort2', 'Feburary');
INSERT INTO cohorts (name, start_date) VALUES('Cohort3', 'March');

INSERT INTO students (name, cohort_id) VALUES('Lauren', 1);
INSERT INTO students (name, cohort_id) VALUES('Tom', 2);
INSERT INTO students (name, cohort_id) VALUES('Lucy', 3);
INSERT INTO students (name, cohort_id) VALUES('Ben', 1);
INSERT INTO students (name, cohort_id) VALUES('John', 2);
INSERT INTO students (name, cohort_id) VALUES('Abbi', 3);