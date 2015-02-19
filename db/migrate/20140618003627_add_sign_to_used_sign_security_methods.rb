class AddSignToUsedSignSecurityMethods < ActiveRecord::Migration
  def change
    add_reference :used_sign_security_methods, :sign, index: true
  end
end
