class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.references :customer, index: true
      t.references :allergen, index: true

      t.timestamps
    end
  end
end
