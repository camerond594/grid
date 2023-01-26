class CreateDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers do |t|
      t.string :driver_id
      t.string :code
      t.string :url
      t.integer :permanent_number
      t.string :given_name
      t.string :family_name
      t.date :date_of_birth
      t.string :nationality

      t.timestamps
    end
  end
end
