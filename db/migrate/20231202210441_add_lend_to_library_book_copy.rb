class AddLendToLibraryBookCopy < ActiveRecord::Migration[7.1]
  def change
    add_column :library_book_copies, :borrower_id, :integer
    add_column :library_book_copies, :due_date, :datetime
  end
end
