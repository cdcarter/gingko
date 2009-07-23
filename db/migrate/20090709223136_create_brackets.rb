class CreateBrackets < ActiveRecord::Migration
  def self.up
    create_table :brackets do |t|
      t.string :name
      t.integer :tournament_id
      t.integer :phase_id
      t.integer :size
      t.timestamps
    end
  end

  def self.down
    drop_table :brackets
  end
end
