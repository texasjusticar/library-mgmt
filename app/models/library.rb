class Library < ApplicationRecord
  has_many :library_book_copies
  has_many :books, through: :library_book_copies
  has_many :library_borrowers
  has_many :borrowers, through: :library_borrowers

  validates :name, presence: true, allow_blank: false
end