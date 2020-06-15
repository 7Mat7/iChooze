class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.text :synopsis
      t.string :date
      t.string :datetime
      t.integer :rating
      t.integer :duration
      t.string :cast
      t.string :photo_url

      t.timestamps
    end
  end
end
