class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :round
      t.integer :tournament_id
      t.integer :bracket_id
      t.integer :phase_id
      t.integer :room_id
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
