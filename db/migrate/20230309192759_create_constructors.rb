class CreateConstructors < ActiveRecord::Migration[7.0]
  def change
    create_table :constructors do |t|
      t.string :name
      t.string :nationality
      t.string :url
    end
  end
end
