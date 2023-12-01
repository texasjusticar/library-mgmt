class Library < ApplicationRecord
  has_many :library_book_copies
  has_many :books, through: :library_book_copies

  validates :name, presence: true, allow_blank: false
end