class CreateData < ActiveRecord::Migration[5.1]
  def change
    create_table :data do |t|
      t.string :type
      t.string :country_code
      t.integer :year
      t.float :value
    end

    add_index :data, [:type, :country_code, :year]
  end
end
