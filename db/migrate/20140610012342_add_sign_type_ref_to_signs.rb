class AddSignTypeRefToSigns < ActiveRecord::Migration
  def change
    add_reference :signs, :sign_type, index: true
  end
end
