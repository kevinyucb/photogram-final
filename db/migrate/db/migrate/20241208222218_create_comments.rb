class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :photo_id
      t.integer :author_id

      t.timestamps
    end
  end
end
