class CreateBrains < ActiveRecord::Migration
  def change
    create_table :brains do |t|
      t.string :kind
      t.string :size

      t.timestamps
    end
  end
end
