class CreateIdentifications < ActiveRecord::Migration[6.1]
  def change
    create_table :identifications, if_not_exists: true do |t|
      t.references :patient, foreign_key: true, dependent: :destroy, index: { unique: true }

      t.string :id_number, null: false, limit: 50
      t.string :state_issuer, null: false, limit: 50
      t.string :url, null: false, limit: 1024
      t.datetime :exp_date, null: false

      t.timestamps
    end
  end
end
