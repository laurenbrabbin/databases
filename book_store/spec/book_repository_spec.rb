require 'book_repository'

RSpec.describe BookRepository do

  def reset_books_table
    seed_sql = File.read('spec/seeds_books.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test'})
    connection.exec(seed_sql)
  end

  describe BookRepository do
    before(:each) do
      reset_books_table
    end
  
    it "will print all books" do
      repo = BookRepository.new

      album = repo.all

      expect(album.first.id).to eq('1')
      expect(album.first.title).to eq('Nineteen Eighty-Four')
      expect(album.first.author_name).to eq('George Orwell')
      expect(album.length).to eq(2)
    end
  end
end