class LibraryBorrower < ActiveRecord::Migration[7.1]
  def change
    create_table :library_borrowers do |r|
      r.integer :borrower_id
      r.integer :library_id
      r.timestamps
    end
  end
end
