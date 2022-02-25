class CreateRecs < ActiveRecord::Migration[6.1]
  def change
    create_table :recs, if_not_exists: true do |t|
      t.references :patient, foreign_key: true, dependent: :destroy, index: { unique: true }

      t.string :rec_number, null: false, limit: 50
      t.string :valid_state, null: false, limit: 50
      t.string :physician_issuer, null: false, limit: 50
      t.string :url, null: false, limit: 1024
      t.datetime :exp_date, null: false

      t.timestamps
    end
  end
end
