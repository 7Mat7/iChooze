class AddUrlsColumnToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :urls, :string, array: true, default: []
  end
end
