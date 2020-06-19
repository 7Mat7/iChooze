class ChangePlatformsInCriteria < ActiveRecord::Migration[6.0]
  def change
    change_column_default :criteria, :platforms, ['cpd', 'dnp', 'ftv', 'itu', 'nfx', 'ocs', 'prv']
  end
end
