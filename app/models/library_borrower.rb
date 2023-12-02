class LibraryBorrower < ApplicationRecord
  belongs_to :borrower
  belongs_to :library
end