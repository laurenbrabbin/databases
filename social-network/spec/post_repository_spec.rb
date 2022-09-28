require 'post_repository'

RSpec.describe PostRepository do 
  def reset_posts_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_posts_table
  end

  it "returns all posts" do
    repo = PostRepository.new

    posts = repo.all
    p posts

    expect(posts.length).to eq(2) 
    expect(posts.first.id).to eq('1') 
    expect(posts.first.title).to eq('title1') 
    expect(posts.first.content).to eq ('content2') 
    expect(posts.first.views).to eq('100') 
    expect(posts.first.account_id).to eq("1") 
  end 

  it "returns the first post" do
    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id).to eq("1") 
    expect(post.title).to eq("title1") 
    expect(post.content).to eq("content2") 
    expect(post.views).to eq("100") 
    expect(post.account_id).to eq("1") 
  end
  it "returns the second post" do
    repo = PostRepository.new

    post = repo.find(2)

    expect(post.id).to eq("2") 
    expect(post.title).to eq("title2") 
    expect(post.content).to eq("content2") 
    expect(post.views).to eq("200") 
    expect(post.account_id).to eq("2") 
  end

  it "creates a new post" do 
    repo = PostRepository.new

    post = Post.new
    post.title = 'title4'
    post.content = 'content4'
    post.views = 400
    post.account_id = 2

    repo.create(post)

    posts = repo.all
    expect(posts.length).to eq(3) 

    last_post = posts.last

    expect(last_post.title).to eq('title4') 
    expect(last_post.content).to eq('content4') 
    expect(last_post.views).to eq('400') 
    expect(last_post.account_id).to eq('2')
  end
  it "deletes a new post" do
    repo = PostRepository.new

    id_to_delete = 1

    repo.delete(id_to_delete)

    all_posts = repo.all
    expect(all_posts.length).to eq(1)
    expect(all_posts.first.id).to eq("2") 
  end 
  it "updates a post" do
    repo = PostRepository.new
    post = repo.find(1)

    post.title = 'new title'
    post.content = 'new content'
    post.views = 1000
    post.account_id = 1

    repo.update(post)

    updated_post = repo.find(1)

    expect(post.title).to eq('new title') 
    expect(post.content).to eq('new content') 
    expect(post.views).to eq(1000) 
    expect(post.account_id).to eq(1) 
  end
end