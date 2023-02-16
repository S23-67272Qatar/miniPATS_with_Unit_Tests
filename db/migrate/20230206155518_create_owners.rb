class CreateOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :owners do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone
      t.string :email
      t.boolean :active

      t.timestamps
    end
  end
end
