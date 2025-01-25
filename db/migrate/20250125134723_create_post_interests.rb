class CreatePostInterests < ActiveRecord::Migration[7.2]
  def change
    create_table :post_interests do |t|
      t.references :post, null: false, foreign_key: true
      t.references :interest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
