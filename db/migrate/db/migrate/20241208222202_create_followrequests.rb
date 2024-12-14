class CreateFollowrequests < ActiveRecord::Migration[7.1]
  def change
    create_table :followrequests do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.string :status

      t.timestamps
    end
  end
end
