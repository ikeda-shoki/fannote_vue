class CreatePostComments < ActiveRecord::Migration[6.0]
  def change
    create_table :post_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post_image, null: false, foreign_key: true
      t.text :comment, null: false

      t.timestamps
    end
  end
end
