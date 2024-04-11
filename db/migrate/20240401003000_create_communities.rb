class CreateCommunities < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :communities do |t|
      t.string :url_identifier, null: false
      t.string :name, null: false
      t.string :invitation_token, null: false
      t.integer :members_count, null: false, default: 1
      t.integer :average_points, null: false, default: 0
      t.string :access, null: false

      t.index [:url_identifier], unique: true
      t.index [:name], unique: true
      t.index [:invitation_token], unique: true

      t.timestamps
    end
  end
end
