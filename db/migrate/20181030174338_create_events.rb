class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.date :date
      t.string :image_url
      t.integer :resort_id
      t.integer :host_id

      t.timestamps
    end
  end
end
