class CreateSigns < ActiveRecord::Migration
  def change
    create_table :signs do |t|
    	t.string :ip_address
    	t.timestamps
    end
  end
end
