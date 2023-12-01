class Book < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.string :author
      t.timestamps
    end
  end
end
