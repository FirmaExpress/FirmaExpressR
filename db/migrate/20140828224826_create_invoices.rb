class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :description
      t.integer :total
    end
  end
end
