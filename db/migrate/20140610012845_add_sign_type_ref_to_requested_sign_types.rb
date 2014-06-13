class AddSignTypeRefToRequestedSignTypes < ActiveRecord::Migration
  def change
    add_reference :requested_sign_types, :sign_type, index: true
  end
end
