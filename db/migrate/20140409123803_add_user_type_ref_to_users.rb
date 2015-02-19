class AddUserTypeRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :user_type, index: true
  end
end
