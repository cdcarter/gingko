class CreatePlayerResults < ActiveRecord::Migration
  def self.up
    #TODO: add player_results columns as well as associations
    create_table :player_results do |t|
      t.integer :powers
      t.integer :tossups
      t.integer :negs
      t.integer :points
      t.integer :tuh
      
      t.integer :player_id
      t.integer :game_id
      t.integer :tournament_id

      t.timestamps
    end
  end

  def self.down
    drop_table :player_results
  end
end
