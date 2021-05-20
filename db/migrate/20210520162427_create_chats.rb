class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.references :user, foreign_key: true, null: false
      t.references :request, foreign_key: true, null: false
      t.text       :message, null: false

      t.timestamps
    end
  end
end
