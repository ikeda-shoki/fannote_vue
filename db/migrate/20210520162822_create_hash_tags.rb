class CreateHashTags < ActiveRecord::Migration[6.0]
  def change
    create_table :hash_tags do |t|
      t.string :hashname

      t.timestamps
    end
    add_index :hash_tags, :hashname, unique: true
  end
end
