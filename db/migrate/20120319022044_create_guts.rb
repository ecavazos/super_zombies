class CreateGuts < ActiveRecord::Migration
  def change
    create_table :guts do |t|
      t.string :kind
      t.string :species

      t.timestamps
    end
  end
end
