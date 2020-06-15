class AddDefaultBooleanToVues < ActiveRecord::Migration[6.0]
  def change
    change_column :vues, :conjoint1, :boolean, default: false
    change_column :vues, :conjoint2, :boolean, default: false
  end
end
