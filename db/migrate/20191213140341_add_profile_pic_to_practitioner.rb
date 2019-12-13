class AddProfilePicToPractitioner < ActiveRecord::Migration[5.2]
  def change
    add_column :practitioners, :profile_pic, :string
  end
end
