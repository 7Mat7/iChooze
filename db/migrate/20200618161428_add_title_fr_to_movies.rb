class AddTitleFrToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :title_fr, :string
  end
end
