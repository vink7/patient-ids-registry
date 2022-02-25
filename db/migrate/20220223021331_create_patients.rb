class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients, if_not_exists: true do |t|
      t.string :first_name, null: false, limit: 50
      t.string :last_name, null: false, limit: 50
      t.string :email, null: false, limit: 100
      t.datetime :dob, null: false

      t.timestamps
    end
  end
end
