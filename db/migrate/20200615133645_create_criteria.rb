class CreateCriteria < ActiveRecord::Migration[6.0]
  def change
    create_table :criteria do |t|
      t.integer :duration
      t.integer :rating
      t.string :platforms, array: true, default: []
      t.references :user

      t.timestamps
    end
  end
end
