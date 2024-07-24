class RenameAffiliationToOccupationInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :affiliation, :occupation
  end
end
