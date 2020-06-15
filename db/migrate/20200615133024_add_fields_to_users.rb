class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :conjoint1, :string
    add_column :users, :conjoint2, :string
    add_column :users, :platforms, :string, array: true, default: []
  end
end
