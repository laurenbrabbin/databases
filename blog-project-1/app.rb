require_relative "lib/database_connection.rb"
require_relative "lib/post_repository.rb"

DatabaseConnection.connect('blog_test')

post_repository = PostRepository.new

p post_repository.find_with_comments(1)