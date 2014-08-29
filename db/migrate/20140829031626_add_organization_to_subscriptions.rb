class AddOrganizationToSubscriptions < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :organization, index: true
  end
end
