class CreateResorts < ActiveRecord::Migration[5.2]
  def change
    create_table :resorts do |t|
      t.string :name
      t.string :region
      t.string :latitude
      t.string :longitude
      t.string :website_url
      t.string :image_url

      t.timestamps
    end
  end
end
