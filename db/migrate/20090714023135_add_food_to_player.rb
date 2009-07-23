class AddFoodToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :email, :string
    add_column :players, :ordered, :boolean
  end

  def self.down
    remove_column :players, :ordered
    remove_column :players, :email
  end
end
