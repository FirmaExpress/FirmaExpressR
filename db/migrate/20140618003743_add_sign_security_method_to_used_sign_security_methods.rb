class AddSignSecurityMethodToUsedSignSecurityMethods < ActiveRecord::Migration
  def change
    add_reference :used_sign_security_methods, :sign_security_method, index: true
  end
end
