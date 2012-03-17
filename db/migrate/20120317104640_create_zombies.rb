class CreateZombies < ActiveRecord::Migration
  def change
    create_table :zombies do |t|
      t.string :name
      t.string :gender
      t.integer :age

      t.timestamps
    end
  end
end
