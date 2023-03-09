class AddConstructorToDriverSeasons < ActiveRecord::Migration[7.0]
  def change
    add_reference :driver_seasons, :constructor, null: true, foreign_key: true, index: true
  end
end
