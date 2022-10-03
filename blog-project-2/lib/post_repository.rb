require_relative './post'
require_relative './tag'
require_relative './database_connection'

class PostRepository
  def find_by_tags(id)
    sql = 'SELECT posts.id, 
          posts.title
          FROM posts
          JOIN posts_tags ON posts_tags.post_id = posts.id
          JOIN tags ON posts_tags.tag_id = tags.id
          WHERE tags.id = $1'
   
    sql_params = [id]

    result = DatabaseConnection.exec_params(sql, sql_params)
    #finding posts from 1 tag
    tag = Tag.new

    tag.id = result.first['id']
    tag.name = result.first['name']

    result.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']

      tag.posts << post
    end  
    return tag
  end
end