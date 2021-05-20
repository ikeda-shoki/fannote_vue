class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :visitor, foreign_key: { to_table: :users }, null: false
      t.references :visited, foreign_key: { to_table: :users }, null: false
      t.references :post_image, foreign_key: true, null: false
      t.references :request, foreign_key: true, null: false
      t.string     :action, default: "", null: false
      t.boolean    :checked, default: false, null: false

      t.timestamps
    end
  end
end
