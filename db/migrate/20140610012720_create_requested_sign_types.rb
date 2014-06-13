class CreateRequestedSignTypes < ActiveRecord::Migration
  def change
    create_table :requested_sign_types do |t|
    	t.timestamps
    end
  end
end
