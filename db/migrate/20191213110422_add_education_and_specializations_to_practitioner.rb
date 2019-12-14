class AddEducationAndSpecializationsToPractitioner < ActiveRecord::Migration[5.2]
  def change
    add_column :practitioners, :education, :string, array: true, default: []
    add_column :practitioners, :specializations, :string, array: true, default: []
  end
end
