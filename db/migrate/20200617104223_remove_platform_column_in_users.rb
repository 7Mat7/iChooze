class RemovePlatformColumnInUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :platforms
    change_column_default :criteria, :platforms, ['cpd', 'dnp', 'itu', 'nfx', 'ocs', 'prv']
  end
end
