# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/book_repository'
require_relative 'lib/book'


# We need to give the database name to the method `connect`.
DatabaseConnection.connect('book_store')

# Perform a SQL query on the database and get the result set.

repo = BookRepository.new

result = repo.all

# Print out each record from the result set .
result.each do |record|
  p "#{record.id} - #{record.title} - #{record.author_name}"
end