require_relative 'lib/database_connection'
require_relative 'lib/artist_repository.rb'
require_relative 'lib/album_repository.rb'
# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library') #connect to main database not test database

artist_repository = ArtistRepository.new
artist_repository.all.each do |artist|
  p artist
end

album_repository = AlbumRepository.new
album_repository.all.each do |album|
  p album
end