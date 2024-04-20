class CreateCommunityMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :community_memberships do |t|
      t.references :community, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role, null: false, default: "member"
      t.integer :ranking_position, null: false, default: 0

      t.index [:community_id, :user_id], unique: true

      t.timestamps
    end
  end
end
