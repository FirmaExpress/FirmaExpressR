class AddSubscriberToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :subscriber, index: true
  end
end
