class AddPriceUsdToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :price_usd, :integer
  end
end
