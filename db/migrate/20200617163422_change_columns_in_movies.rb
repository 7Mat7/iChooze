class ChangeColumnsInMovies < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :datetime
    remove_column :movies, :cast
    add_column :movies, :cast, :string, array: true, default: []
end
end
