require 'artist_repository'

RSpec.describe ArtistRepository do 
  
  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do #before each test do the above
    reset_artists_table
  end 

  it "returns a list of artists" do
    repo = ArtistRepository.new
    
    artists = repo.all

    expect(artists.length).to eq(2) # 2 since there are 2 columns
    expect(artists.first.id).to eq('1') 
    expect(artists.first.name).to eq('Pixies') # => 'Pixies'
  end

  it 'returns the Pixies as single artist' do
    repo = ArtistRepository.new

    artist = repo.find(1)

    expect(artist.id).to eq("1") # =>  1
    expect(artist.name).to eq('Pixies') # =>  'Pixies'
    expect(artist.genre).to eq('Rock') # =>  'Rock'
  end

  it 'returns the Pixies as single artist' do
    repo = ArtistRepository.new

    artist = repo.find(2)

    expect(artist.id).to eq("2") # =>  1
    expect(artist.name).to eq('Abba') # =>  'Pixies'
    expect(artist.genre).to eq('Pop') # =>  'Rock'
  end

  it "adds a new artist" do
    repo = ArtistRepository.new

    new_artist = Artist.new
    new_artist.name = 'Beatles'
    new_artist.genre = 'Pop'

    repo.create(new_artist)

    artists = repo.all

    last_artist = artists.last
    
    expect(last_artist.name).to eq('Beatles') 
    expect(last_artist.genre).to eq('Pop') 
  end

  it "deletes an artist" do
    repo = ArtistRepository.new

    id_to_delete = 1

    repo.delete(id_to_delete)

    all_artists = repo.all
    expect(all_artists.first.id).to eq("2") #because one should be deleted
  end

  it "deletes the two artists" do
    repo = ArtistRepository.new

    repo.delete(1) #deleting artists with id one and two
    repo.delete(2)

    all_artists = repo.all
    expect(all_artists.length).to eq(0) #because one should be deleted
  end

  it "updates the artist" do
    repo = ArtistRepository.new
    artist = repo.find(1)

    artist.name = 'something else'
    artist.genre = 'disco'

    repo.update(artist)

    updated_artist = repo.find(1)

    expect(updated_artist.name).to eq('something else') 
    expect(updated_artist.genre).to eq ('disco') 
  end
  it "updates new name only" do
    repo = ArtistRepository.new
    artist = repo.find(1)

    artist.name = 'something else'

    repo.update(artist)

    updated_artist = repo.find(1)

    expect(updated_artist.name).to eq('something else') 
    expect(updated_artist.genre).to eq ('Rock') 
  end
end 