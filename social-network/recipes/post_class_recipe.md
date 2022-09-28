https://github.com/makersacademy/databases/blob/main/resources/repository_class_recipe_template.md 

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

TRUNCATE TABLE arists RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'May 2022');
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.
```
```bash
#create test database, load in the file with data which was provided by coaches (psql -h 127.0.0.1 music_library_test < music_database.sql) and then push this test database to our spec/seeds_artist file 9psql -h 127.0.0.1 music_library_test < spec/seeds_artists.sql;)

psql -h 127.0.0.1 music_library_test < music_database.sql

psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: accounts

# Model class
# (in lib/student.rb)
class Account
end

# Repository class
# (in lib/student_repository.rb)
class AccountRepository
end

## 4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: accounts

# Model class
# (in lib/accounts.rb)

class Account

  # Replace the attributes by your own columns.
  attr_accessor :id, :username, :email
end

class Post
 attr_accessor :id, :title, :content, :account_id
end
# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,

# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name

You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

## 5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: account

# Repository class
# (in lib/artist_repository.rb)

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Artist objects.
  end
  def find(id)
    #execute SQL query:
    #SELECT id, name, genre FROM artists WHERE id = $1
end

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Artist objects.
  end
  def find(id)
    #execute SQL query:
    #SELECT id, name, genre FROM artists WHERE id = $1
end

## 6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.
```ruby
# EXAMPLES

# 1
# Get all posts

repo = PostRepository.new

posts = repo.all
posts.length # => 3 
posts.first.id # => '1'
posts.first.title # => 'title1'
posts.first.content # => 'content2'
posts.first.views # => '100'
posts.first.account_id # => '1'

# 2
# Get a single post

repo = PostRepository.new

post = repo.find(1)

post.id # =>  1
post.title # =>  'title1'
post.content # =>  'content2'
post.views # => '100'
post.account_id # => '1'

#3
#get another single post

repo = PostRepository.new

post = repo.find(2)

post.id # =>  2
post.title # =>  'title2'
post.content # =>  'content2'
post.views # => '200'
post.account_id # => '2'

#4 create a new post
repo = PostRepository.new

post = Post.new
post.title = 'title4'
post.content = 'content4'
post.views = '400'
post.account_id = 2

repo.create(post)

posts = repo.all
posts.length # => 4

last_post = posts.last
last_post.title # => 'title4'
last_post.content # => 'content4'
last_post.views # => '400'
last_post.account_id # => '2'

#5 Delete a post 
repo = PostRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_posts = repo.all
all_posts.first.id # => 2

#6 Updating
repo = PostRepository.new
post = repo.find(1)

post.title = 'new title'
post.content = 'new content'
post.views = 1000
post.account_id = 1

repo.update(post)

updated_post = repo.find(1)

post.title # => 'new title'
post.content # => 'new content'
post.views # => 1000
post.account_id # => 1


# Add more examples for each method
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