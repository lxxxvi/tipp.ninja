class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :fifa_code, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
