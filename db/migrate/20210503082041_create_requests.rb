class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :requester, null: false, foreign_key: { to_table: :users }
      t.references :requested, null: false, foreign_key: { to_table: :users }
      t.text :request_introduction, null: false
      t.integer :file_format, default: 0, null: false
      t.text :use, null: false
      t.date :deadline, null: false
      t.integer :amount, default: 1, null: false
      t.integer :request_status, default: 0, null: false

      t.timestamps
    end
  end
end
