class CreateJobResource < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :state, null: false
    end
  end
end
