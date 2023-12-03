class LibraryBookCopy < ApplicationRecord
  belongs_to :book
  belongs_to :library, optional: true
  belongs_to :borrower, optional: true
end