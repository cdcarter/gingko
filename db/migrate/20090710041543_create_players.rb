class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :tournament_id
      t.integer :team_id
      
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
