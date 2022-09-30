require 'post_repository'
require 'database_connection'


RSpec.describe PostRepository do 
  def reset_posts_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'blogs_test' })
    connection.exec(seed_sql)
  end

  before(:each) do #before each test do the above
    reset_posts_table
  end 

  it "returns the comments on the second post" do
    repo = PostRepository.new

    post = repo.find_with_comments(2) #find students in cohort 1
    expect(post.title).to eq('Tuesday') 
    expect(post.content).to eq('I went to the swimming pool')
    expect(post.comments.length).to eq(2) 
    expect(post.comments.first.author).to eq("lauren") 
  end
  it "returns the comments on the first post" do
    repo = PostRepository.new

    post = repo.find_with_comments(1) #find students in cohort 1
    expect(post.title).to eq('Monday') 
    expect(post.content).to eq('I went to the shop')
    expect(post.comments.length).to eq(2) 
    expect(post.comments.first.author).to eq("emily") 
  end
end 

