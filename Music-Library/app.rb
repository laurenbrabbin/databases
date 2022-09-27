require_relative 'lib/database_connection'
require_relative 'lib/artist_repository.rb'
require_relative 'lib/album_repository.rb'
# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library') #connect to main database not test database

# Print all artists

    #artist_repository = ArtistRepository.new
    #artist_repository.all.each do |artist|
    #  p artist
    #end

#prints all albums

    #album_repository = AlbumRepository.new
    #album_repository.all.each do |album|
    #  p album
    #end

#prints the first artist

    #repo = ArtistRepository.new
    #artist = repo.find(1)
    #puts artist.name # --> Pixies

#prints the fourth artist
    #repo = ArtistRepository.new
    #artist = repo.find(4)
    #puts artist.name --> Nina Simone

#prints the 3rd album
artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new

album = album_repository.find(3)
puts album.title