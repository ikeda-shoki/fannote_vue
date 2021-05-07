class CreatePostImages < ActiveRecord::Migration[6.0]
  def change
    create_table :post_images do |t|
      t.references :user, foreign_key: true, null: false
      t.string     :title, null: false
      t.text       :image_introduction
      t.integer    :post_image_genre, default: 0, null: false

      t.timestamps
    end
  end
end
