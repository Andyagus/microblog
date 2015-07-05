class AddProfileToUser < ActiveRecord::Migration
  def change
   add_column :users, :bio, :string
   add_column :users, :religion, :string
  end
end
