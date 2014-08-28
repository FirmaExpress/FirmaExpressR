class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string, :name
      t.integer, :documents_per_user
      t.integer, :documents_per_month
      t.boolean, :templantes
      t.boolean, :statistics
      t.boolean, :admin_panel
      t.boolean, :api
      t.integer :price

      t.timestamps
    end
  end
end
