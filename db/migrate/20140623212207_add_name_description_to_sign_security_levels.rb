class AddNameDescriptionToSignSecurityLevels < ActiveRecord::Migration
  def change
    add_column :sign_security_levels, :name, :string
    add_column :sign_security_levels, :description, :string
  end
end
