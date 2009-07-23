class AddMetaDataToPhase < ActiveRecord::Migration
  def self.up
    add_column :phases, :note, :text
  end

  def self.down
    remove_column :phases, :note
  end
end
