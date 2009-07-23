class AddEnteredToGame < ActiveRecord::Migration
  def self.up
    add_column :games, :entered, :boolean
  end

  def self.down
    remove_column :games, :entered
  end
end
