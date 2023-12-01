class LibraryBookCopy < ActiveRecord::Migration[7.1]
  def change
    create_table :library_book_copies do |r|
      r.integer :book_id
      r.integer :library_id
      r.timestamps
    end
  end
end
