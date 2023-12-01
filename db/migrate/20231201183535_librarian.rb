class Librarian < ActiveRecord::Migration[7.1]
  def change
    create_table :librarians do |t|
      t.string :name
      t.string :auth_token
      t.timestamps
    end
    add_index :librarians, :auth_token, unique: true
  end
end
