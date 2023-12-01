class Book < ApplicationRecord
  has_many :library_book_copies
  has_many :libraries, through: :library_book_copies

  validates_presence_of :title, :isbn, :author
end