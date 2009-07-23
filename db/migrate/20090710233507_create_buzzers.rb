class CreateBuzzers < ActiveRecord::Migration
  def self.up
    create_table :buzzers do |t|
      t.integer :team_id
      t.integer :tournament_id
      t.integer :room_id
      t.string :identifier
      t.timestamps
    end
  end

  def self.down
    drop_table :buzzers
  end
end
