class AddMetaDataToTournament < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :date, :string
    add_column :tournaments, :location, :string
  end

  def self.down
    remove_column :tournaments, :string
    remove_column :tournaments, :string
  end
end
