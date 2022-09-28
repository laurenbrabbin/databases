require 'album_repository'

RSpec.describe AlbumRepository do 
  
  def reset_album_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do #before each test do the above
    reset_album_table
  end 

  it "returns a list of albums" do
    repo = AlbumRepository.new
    
    album = repo.all

    expect(album.first.id).to eq('1') 
    expect(album.first.title).to eq('Doolittle') 
    expect(album.first.release_year).to eq('1989')
    expect(album.first.artist_id).to eq('1')  
  end

  it "finds a single album" do 
    repo = AlbumRepository.new

    album = repo.find(1)
 
    expect(album.title).to eq("Doolittle") 
    expect(album.release_year).to eq ('1989')
    expect(album.artist_id).to eq("1") 
  end

  it "finds a single album" do 
    repo = AlbumRepository.new

    album = repo.find(2)
 
    expect(album.title).to eq("Surfer Rosa") 
    expect(album.id).to eq("2")
    expect(album.release_year).to eq ('1988')
    expect(album.artist_id).to eq("1") 
  end
  it "creates a new album" do
    repo = AlbumRepository.new

    new_album = Album.new
    new_album.title = 'Super Trouper'
    new_album.release_year = 1980
    new_album.artist_id = 2

    repo.create(new_album)

    all_albums = repo.all
    
    expect(all_albums).to include(
      have_attributes(
      title: new_album.title, 
      release_year: '1980',
      artist_id: '2' 
      )
    )
    #last_album = all_albums.last
    #expect(last_album.title).to eq('Super Troup')
    #expect(last_album.release_year).to eq('1980') 
    #expect(last_album.artist_id).to eq('2')
  end
end 