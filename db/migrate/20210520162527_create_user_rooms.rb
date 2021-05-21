class CreateUserRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :user_rooms do |t|
      t.references :user, foreign_key: true, null: false
      t.references :request, foreign_key: true, null: false

      t.timestamps
    end
  end
end
