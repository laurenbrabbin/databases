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

    expect(album.length).to eq(2) 
    expect(album.first.id).to eq('1') 
    expect(album.first.title).to eq('Doolittle') 
    expect(album.first.release_year).to eq('1989')
    expect(album.first.artist_id).to eq('1')  
  end
end 