class AddFeeToTournament < ActiveRecord::Migration
  def self.up
    add_column :tournaments, :base_fee, :integer
    add_column :tournaments, :buzzer_discount, :integer
    add_column :tournaments, :moderator_discount, :integer
    add_column :tournaments, :laptop_discount, :integer
  end

  def self.down
    remove_column :tournaments, :laptop_discount
    remove_column :tournaments, :moderator_discount
    remove_column :tournaments, :buzzer_discount
    remove_column :tournaments, :base_fee
  end
end
