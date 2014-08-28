class AddSubscriptionToInvoices < ActiveRecord::Migration
  def change
    add_reference :invoices, :subscription, index: true
  end
end
