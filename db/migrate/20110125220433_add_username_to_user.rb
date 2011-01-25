class AddUsernameToUser < ActiveRecord::Migration
  def self.up
     add_column :users, :user_name, :string
  end

  def self.down
    remove_column :users, :user_name
  end
end
