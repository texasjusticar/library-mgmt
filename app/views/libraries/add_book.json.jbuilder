json.library do
  json.id @library.id
  json.name @library.name
end

json.book do
  json.id @book.id
  json.title @book.title
  json.isbn @book.isbn
  json.author @book.author
end