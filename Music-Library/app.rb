require_relative 'lib/database_connection'
require_relative 'lib/artist_repository.rb'
require_relative 'lib/album_repository.rb'
# We need to give the database name to the method `connect`.

class Application

  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name) #connect to main database not test database
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    welcome_user
    print_interface
    user_selection(@io.gets.chomp)
    exit
  end

  def welcome_user
    @io.puts "Welcome to the music library manager"
  end

  def print_interface
    @io.puts "What would you like to do?"
    @io.puts "1 - List all albums"
    @io.puts "2 - List all artists"
  end

  def user_selection(user_input)
    case user_input
    when "1"
      @io.puts "Here is a list of albums:"
      all_albums
    when "2"
      @io.puts "Here is a list of artists:"
      all_artists
    else
      @io.puts "Sorry I don't understand, please enter 1 or 2"
    end
  end

  def all_albums
    @album_repository.all.each do |album|
        @io.puts "#{album.id} - #{album.title}"
    end
  end

  def all_artists
    @artist_repository.all.each do |artist|
        @io.puts "#{artist.id} - #{artist.name}"
    end
  end

  if __FILE__ == $0
    app = Application.new(
      'music_library',
      Kernel,
      AlbumRepository.new,
      ArtistRepository.new
    )
    app.run
  end
end

#run
#album_repository = AlbumRepository.new
#artist_repository = ArtistRepository.new
#database_name = 'music_library'
#Application.new(database_name, Kernel, album_repository, artist_repository).run


























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
#artist_repository = ArtistRepository.new
#album_repository = AlbumRepository.new

#album = album_repository.find(3)
#puts album.title