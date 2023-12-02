json.array! @books do |book|
  json.copy_id book.library_book_copies.first.id
  json.title book.title
  json.author book.author
  json.isbn book.isbn
end