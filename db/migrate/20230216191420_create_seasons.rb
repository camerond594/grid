class CreateSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :seasons do |t|
      t.string :year
      t.string :url

      t.timestamps
    end
  end
end
