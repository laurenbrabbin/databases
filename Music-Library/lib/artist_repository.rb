require_relative './artist'
require_relative './database_connection'

class ArtistRepository
  def all
    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    artists = []

    result_set.each do |record|
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    end

    return artists
  end

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;' #system will notice theres a placehold $1 and will then use params to see what it should represent
    sql_params = [id] #binding the $1 to id

    result_set = DatabaseConnection.exec_params(sql,sql_params) #sending both the sql and params
    
    record = result_set[0]
    

    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']

    return artist
  end

  def create(artist)
    #execute sql query: 'INSERT INTO artists (name, genre) VALUES($1, $2);'
    sql = 'INSERT INTO artists (name, genre) VALUES($1, $2);'
    sql_params = [artist.name, artist.genre]

    DatabaseConnection.exec_params(sql,sql_params)

    return nil
  end
  
  def delete(id)
    #execute sql query: DELETE FROM artist WHERE id = $1;
    sql = 'DELETE FROM artists WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql,sql_params)

    return nil
  end

  def update(artist)
    #executes the sql: UPDATE ARTIST SET name = $1, genre = $2 WHERE id = $3;
    sql = "UPDATE artists SET name = $1, genre = $2 WHERE id = $3;"
    sql_params = [artist.name, artist.genre, artist.id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end