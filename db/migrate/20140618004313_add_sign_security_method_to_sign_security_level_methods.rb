class AddSignSecurityMethodToSignSecurityLevelMethods < ActiveRecord::Migration
  def change
    add_reference :sign_security_level_methods, :sign_security_method, index: true
  end
end
