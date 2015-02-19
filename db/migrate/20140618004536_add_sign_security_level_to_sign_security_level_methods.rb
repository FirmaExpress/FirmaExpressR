class AddSignSecurityLevelToSignSecurityLevelMethods < ActiveRecord::Migration
  def change
    add_reference :sign_security_level_methods, :sign_security_level, index: true
  end
end
