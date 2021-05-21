class CreatePostImageHashtagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :post_image_hashtag_relations do |t|
      t.references :post_image, foreign_key: true, null: false
      t.integer :hash_tag_id, null: false

      t.timestamps
    end
  end
end
