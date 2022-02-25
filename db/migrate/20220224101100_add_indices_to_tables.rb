class AddIndicesToTables < ActiveRecord::Migration[6.1]
  def change
    add_index :patients, :email, unique: true
    add_index :identifications, [:id_number, :state_issuer], unique: true
    add_index :recs, [:rec_number, :physician_issuer], unique: true
  end
end
