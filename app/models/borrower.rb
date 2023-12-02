class Borrower < ApplicationRecord
  has_many :library_borrowers
  has_many :libraries, through: :library_borrowers
  has_many :books, through: :library_book_copies
  has_many :library_book_copies

  validates_presence_of :name, :cc_expiration, :cc_number, allow_blank: false
end