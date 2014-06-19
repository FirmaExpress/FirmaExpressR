class CreateSignSecurityLevels < ActiveRecord::Migration
  def change
    create_table :sign_security_levels do |t|
      t.integer :level

      t.timestamps
    end
  end
end
