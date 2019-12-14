class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :nationality
      t.text :address
      t.string :postal_code
      t.date :birthday
      t.string :languages, array: true, default: []
      t.string :passport
      t.string :contact_number
      t.bigint :points, null: false, default: 0

      t.timestamps
    end
  end
end
