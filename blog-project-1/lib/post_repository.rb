require_relative './post'
require_relative './comment'
require_relative './database_connection'

class PostRepository
  def find_with_comments(id)
    sql = 'SELECT posts.id,
          posts.title,
          posts.content,
          comments.id AS comment_id,
          comments.author,
          comments.content AS comments_content
    FROM posts
    JOIN comments ON comments.post_id = posts.id
    WHERE posts.id = $1;'
    
    sql_params = [id]
    
    result = DatabaseConnection.exec_params(sql, sql_params)

    post = Post.new

    post.id = result.first['id']
    post.title = result.first['title']
    post.content = result.first['content']

    result.each do |record|
      comment = Comment.new
      comment.id = record['comment_id']
      comment.author = record['author']
      comment.content = record['comments_content']

      post.comments << comment
    end

    return post
  end
end