class AddSubscriberToOrganizations < ActiveRecord::Migration
  def change
    add_reference :organizations, :subscriber, index: true
  end
end
