class CreateBicycle < ActiveRecord::Migration[6.1]
  def change
    create_table :bicycles, id: :uuid do |t|
      t.string :colour
      t.integer :wheel_size
      t.integer :gear_amount
    end
  end
end
