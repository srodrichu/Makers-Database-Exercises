class BookRepository

    def all
        sql = "SELECT * FROM books"
        result = DatabaseConnection.exec_params(sql, [])

        result = result.map do |record|
            book = Book.new
            book.id = record["id"]
            book.title = record["title"]
            book.author_name = record["author_name"]
            record = book
        end
    end

    def find(id)

        sql = "SELECT * FROM books WHERE id = #{id}"
        result = DatabaseConnection.exec_params(sql, [])

        book = Book.new
        book.id = result[0]["id"]
        book.title = result[0]["title"]
        book.author_name = result[0]["author_name"]

        book

    end

    def create(book)
        sql = "INSERT INTO books (title, author_name) 
        VALUES ('#{book.title}', '#{book.author_name}')"

        result = DatabaseConnection.exec_params(sql, [])
    end

    def update(id, book)
        sql = "UPDATE books
        SET title = '#{book.title}', author_name = '#{book.author_name}'
        WHERE id = #{id}"

        DatabaseConnection.exec_params(sql, [])
    end

    def delete(id)

        sql = "DELETE FROM books WHERE id = #{id}"
        DatabaseConnection.exec_params(sql, [])

    end
    
end
