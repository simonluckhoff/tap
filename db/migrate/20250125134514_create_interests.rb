class CreateInterests < ActiveRecord::Migration[7.2]
  def change
    create_table :interests do |t|
      t.text :title

      t.timestamps
    end
  end
end
