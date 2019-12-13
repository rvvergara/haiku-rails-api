class AddProfilePicToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :profile_pic, :string
  end
end
