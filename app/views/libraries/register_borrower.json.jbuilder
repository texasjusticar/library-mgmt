json.library do
  json.id @library.id
  json.name @library.name
end

json.borrower do
  json.id @borrower.id
  json.name @borrower.name
end