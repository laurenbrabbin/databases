require_relative "../app.rb"
require_relative "../lib/album_repository.rb"
require_relative "../lib/artist_repository.rb"

RSpec.describe Application do

  def reset_album_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_album_table
    reset_artists_table
  end 

  describe "#welcome_user" do
    it "welcomes the user" do
      album_repository = double :album_repository
      artist_repository = double :artist_repository
      io = double :io
      database_name = 'music_library'
      app = Application.new(database_name, io, album_repository, artist_repository)
      
      expect(io).to receive(:puts).with("Welcome to the music library manager")
      
      app.welcome_user
    end
  end
  describe "printe_interface" do
    it "prints list of options" do
      album_repository = double :album_repository
      artist_repository = double :artist_repository
      io = double :io
      database_name = 'music_library'
      app = Application.new(database_name, io, album_repository, artist_repository)
      
      expect(io).to receive(:puts).with("What would you like to do?")
      expect(io).to receive(:puts).with("1 - List all albums")
      expect(io).to receive(:puts).with("2 - List all artists")
      
      app.print_interface
    end
  end
  describe "#user_selection" do
    it "returns all albums" do
      album_repository = AlbumRepository.new
      artist_repository = double :artist_repository
      io = double :io
      database_name = 'music_library_test'
      app = Application.new(database_name, io, album_repository, artist_repository)
      
      expect(io).to receive(:puts).with("Here is a list of albums:").ordered
      expect(io).to receive(:puts).with("1 - Doolittle").ordered
      expect(io).to receive(:puts).with("2 - Surfer Rosa").ordered
      
      app.user_selection("1")
    end
    it "returns all artists" do
      album_repository = double :album_repository
      artist_repository = ArtistRepository.new
      io = double :io
      database_name = 'music_library_test'
      app = Application.new(database_name, io, album_repository, artist_repository)
      
      expect(io).to receive(:puts).with("Here is a list of artists:").ordered
      expect(io).to receive(:puts).with("1 - Pixies").ordered
      expect(io).to receive(:puts).with("2 - Abba").ordered
      
      app.user_selection("2")
    end
    it "lets user know if it doesn't understand input" do
      album_repository = double :album_repository
      artist_repository = double :artist_repository
      io = double :io
      database_name = 'music_library_test'
      app = Application.new(database_name, io, album_repository, artist_repository)
      
     
      expect(io).to receive(:puts).with("Sorry I don't understand, please enter 1 or 2").ordered
      
      app.user_selection("T")
    end
  end
end