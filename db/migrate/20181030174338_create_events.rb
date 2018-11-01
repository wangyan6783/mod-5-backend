class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :category
      t.datetime :start_time
      t.datetime :end_time
      t.integer :resort_id
      t.integer :host_id

      t.timestamps
    end
  end
end
