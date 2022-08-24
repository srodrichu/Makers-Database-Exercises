require 'book_repository'
require 'book'
require 'pg'

def reset_book_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store' })
    connection.exec(seed_sql)
  end
  
  describe BookRepository do
    before(:each) do 
      reset_book_table
    end

    it "get #all books from the db" do
        repo = BookRepository.new
        results = repo.all

        expect(results.length).to eq 5
        expect(results[0].id).to eq "1"
        expect(results[0].title).to eq "Nineteen Eighty-Four"
        expect(results[0].author_name).to eq "George Orwell"
    end

    it "#finds book by id" do

        repo = BookRepository.new
        results = repo.find(1)

        expect(results.id).to eq "1"
        expect(results.title).to eq "Nineteen Eighty-Four"
        expect(results.author_name).to eq "George Orwell"

    end

    it "creates a new entry into the db" do

        repo = BookRepository.new
        book = Book.new
        book.id = 6
        book.title = "New"
        book.author_name = "Author"
        repo.create(book)

        results = repo.all

        expect(results.length).to eq 6
        expect(results[-1].id).to eq "6"
        expect(results[-1].title).to eq "New"
        expect(results[-1].author_name).to eq "Author"

    end

    it "updates a new entry into the db" do

        repo = BookRepository.new
        book = Book.new
        book.title = "New"
        book.author_name = "Author"
        repo.update(1, book)

        results = repo.find(1)
        expect(results.id).to eq "1"
        expect(results.title).to eq "New"
        expect(results.author_name).to eq "Author"
    end

    it "#deletes entry by id" do

        repo = BookRepository.new
        repo.delete(1)

        results = repo.all
        expect(results.length).to eq 4
        expect(results[0].id).to eq "2"
        expect(results[0].title).to eq "Mrs Dalloway"
        expect(results[0].author_name).to eq "Virginia Woolf"
    end
  end