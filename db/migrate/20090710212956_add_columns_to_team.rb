class AddColumnsToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :fee, :integer
    add_column :teams, :info, :string
  end

  def self.down
    remove_column :teams, :info
    remove_column :teams, :fee
  end
end
