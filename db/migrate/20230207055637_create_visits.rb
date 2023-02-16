class CreateVisits < ActiveRecord::Migration[7.0]
  def change
    create_table :visits do |t|
      t.date :date
      t.float :weight
      t.boolean :overnight_stay
      t.float :total_charge
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
