class AddBrainAndGutAssociationToZombie < ActiveRecord::Migration
  def change
    add_column :zombies, :brain_id, :integer
    add_column :zombies, :gut_id,   :integer

    add_index :zombies, :brain_id
    add_index :zombies, :gut_id
  end
end
