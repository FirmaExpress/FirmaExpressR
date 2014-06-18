class CreateUsedSignSecurityMethods < ActiveRecord::Migration
  def change
    create_table :used_sign_security_methods do |t|

      t.timestamps
    end
  end
end
