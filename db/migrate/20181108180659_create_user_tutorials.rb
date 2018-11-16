class CreateUserTutorials < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tutorials do |t|
      t.integer :user_id
      t.integer :tutorial_id

      t.timestamps
    end
  end
end
