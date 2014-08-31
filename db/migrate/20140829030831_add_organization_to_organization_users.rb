class AddOrganizationToOrganizationUsers < ActiveRecord::Migration
  def change
    add_reference :organization_users, :organization, index: true
  end
end
