class CreateGameAssignments < ActiveRecord::Migration
  def self.up
    create_table :game_assignments do |t|
      t.integer :game_id
      t.integer :team_id
      t.integer :tournament_id
      t.integer :bracket_id
      t.timestamps
    end
  end

  def self.down
    drop_table :game_assignments
  end
end
