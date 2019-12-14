class CreatePractitioners < ActiveRecord::Migration[5.2]
  def change
    create_table :practitioners, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :biography, null: false, default: ''
      t.string :years_exp, null: false, default: 0

      t.timestamps
    end
  end
end
