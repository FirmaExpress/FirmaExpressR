class AddSignSecurityLevelToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :sign_security_level, index: true
  end
end
