class Borrower < ActiveRecord::Migration[7.1]
  def change
    create_table :borrowers do |t|
      t.string :name
      t.string :cc_number
      t.string :cc_expiration
      t.timestamps
    end
  end
end
