class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.integer :author_id
      t.text :body
      t.integer :photo_id

      t.timestamps
    end
  end
end
