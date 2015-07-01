class CreateProfiles < ActiveRecord::Migration
  def change
   create_table :profiles do |t|
      t.string :bio
      t.string :religion
      t.integer :user_id
   end
  end
end
