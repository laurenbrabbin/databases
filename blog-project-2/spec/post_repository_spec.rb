require 'post_repository'
require 'database_connection'

RSpec.describe PostRepository do 
  def reset_posts_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'blogs_2_test' })
    connection.exec(seed_sql)
  end

  before(:each) do #before each test do the above
    reset_posts_table
  end 

  it "returns all the post with a given tag id" do

    repo = PostRepository.new

    posts = repo.find_by_tags(1) #find all posts with tag id 1

    expect(posts.length).to eq(4) # => 4
    expect(posts.first.title).to eq('How to use Git')
  end
end