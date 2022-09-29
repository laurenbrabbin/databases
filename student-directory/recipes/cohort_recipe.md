{{TABLE NAME}} Model and Repository Classes Design Recipe

## 1. Design and create the Table
If the table is already created in the database, you can skip this step.

Tables is already created

## 2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE cohorts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO cohorts (name, start_date) VALUES('Cohort1', 'Janurary');
INSERT INTO cohorts (name, start_date) VALUES('Cohort2', 'Feburary');
INSERT INTO cohorts (name, start_date) VALUES('Cohort3', 'March');
```
```bash
#create test database, load in the file with data which was provided by coaches (psql -h 127.0.0.1 music_library_test < music_database.sql) and then push this test database to our spec/seeds_artist file 9psql -h 127.0.0.1 music_library_test < spec/seeds_artists.sql;)

```

## 3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: cohort

# Model class
# (in lib/cohort.rb)
class Cohort
end

# Repository class
# (in lib/cohort_repository.rb)
class CohortRepository
end

## 4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: cohorts

# Model class
# (in lib/cohort.rb)

class Cohort
  attr_accessor :id, :name, :start_date
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,


You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

## 5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: cohort

# Repository class
# (in lib/cohort_repository.rb)

class CohortRepository
  def find_with_students
    # Executes the SQL query:

    # SELECT cohorts.id AS "id",
      cohorts.name AS "name"
      cohorts.start_date AS "start date"
      students.id AS "student ID"
      students.name AS "student name"
      FROM cohorts
      JOIN students
      ON students.cohort_id = cohort.id
      WHERE cohorts.id = $1
  end
end

## 6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.
```ruby
# EXAMPLES

# 1
# finds all students in a given cohort

  repo = CohortRepository.new

  cohort = repo.find_with_students(1) #find students in cohort 1

  cohort.name # => 'Cohort1'
  cohort.start_date # => 'Janurary'
  cohort.students.length # => 2
  cohort.students.first.name # => 'Lauren'


Encode this example as a test.
```

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_artists.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music-library' })
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do 
    reset_artist_table
  end

  # (your tests will go here).
end

## 8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.