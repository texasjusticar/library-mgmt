json.due_date @book_copy.due_date
json.copy_id @book_copy.id
json.library @library.name
json.borrower do
  @borrower.name
end