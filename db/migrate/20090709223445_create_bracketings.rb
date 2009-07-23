class CreateBracketings < ActiveRecord::Migration
  def self.up
    create_table :bracketings do |t|
      t.integer :team_id
      t.integer :bracket_id
      t.integer :tournament_id
      t.integer :phase_id
      t.timestamps
    end
  end

  def self.down
    drop_table :bracketings
  end
end
