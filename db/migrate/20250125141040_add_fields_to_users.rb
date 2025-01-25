class AddFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :bio, :text
    add_column :users, :username, :string
  end
end
