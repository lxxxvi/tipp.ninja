class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :fifa_code, null: false
      t.string :name, null: false
      t.string :flag, null: false

      t.index [:fifa_code], unique: true
      t.index [:name], unique: true
      t.index [:flag], unique: true

      t.timestamps
    end
  end
end
