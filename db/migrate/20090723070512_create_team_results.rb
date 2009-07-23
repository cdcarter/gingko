class CreateTeamResults < ActiveRecord::Migration
  def self.up
    #TODO: add team_results columns as well as associations
    create_table :team_results do |t|
      t.integer :tuh
      t.boolean :win
      t.integer :points
      t.integer :bonus_heard
      t.integer :bonus_points
      t.integer :powers
      t.integer :tossups
      t.integer :negs
      
      t.integer :team_id
      t.integer :tournament_id
      t.integer :game_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :team_results
  end
end
