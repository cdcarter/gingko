class CreateUserAssignments < ActiveRecord::Migration
  def self.up
    create_table :user_assignments do |t|
      t.integer :user_id
      t.integer :tournament_id
      t.boolean :superuser
      t.timestamps
    end
  end

  def self.down
    drop_table :user_assignments
  end
end
