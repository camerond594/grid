class CreateDriverSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :driver_seasons do |t|
      t.references :driver
      t.references :season

      t.timestamps
    end
  end
end
