class AddSignImageToUser < ActiveRecord::Migration
  def self.up
    add_attachment :users, :sign_image
  end

  def self.down
    remove_attachment :users, :sign_image
  end
end
