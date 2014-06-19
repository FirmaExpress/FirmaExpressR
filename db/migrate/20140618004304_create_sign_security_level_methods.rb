class CreateSignSecurityLevelMethods < ActiveRecord::Migration
  def change
    create_table :sign_security_level_methods do |t|

      t.timestamps
    end
  end
end
