class AddAgreedAtToDocuments < ActiveRecord::Migration
  def change
  	add_column :documents, :agreed_at, :datetime
  end
end
