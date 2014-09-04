class AddUserToOrganizationUsers < ActiveRecord::Migration
  def change
    add_reference :organization_users, :user, index: true
  end
end
