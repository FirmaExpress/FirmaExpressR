class AddSubscriberToSubscriptions < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :subscriber, index: true
  end
end
