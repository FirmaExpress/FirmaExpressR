class CreateSignSecurityMethods < ActiveRecord::Migration
  def change
    create_table :sign_security_methods do |t|
      t.string :name

      t.timestamps
    end
  end
end
