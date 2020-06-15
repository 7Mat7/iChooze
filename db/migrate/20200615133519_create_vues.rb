class CreateVues < ActiveRecord::Migration[6.0]
  def change
    create_table :vues do |t|
      t.references :user
      t.references :movie
      t.boolean :conjoint1
      t.boolean :conjoint2

      t.timestamps
    end
  end
end
