class CreateGroupEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :group_events do |t|
      t.date :start_at
      t.date :end_at
      t.integer :duration
      t.integer :status
      t.string :name
      t.text :description
      t.string :location

      t.timestamps
    end
  end
end
