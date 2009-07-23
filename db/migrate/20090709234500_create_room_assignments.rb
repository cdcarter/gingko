class CreateRoomAssignments < ActiveRecord::Migration
  def self.up
    create_table :room_assignments do |t|
      t.integer :tournament_id
      t.integer :bracket_id
      t.integer :room_id
      t.timestamps
    end
  end

  def self.down
    drop_table :room_assignments
  end
end
