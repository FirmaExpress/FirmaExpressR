class AddDocumentRefToRequestedSignTypes < ActiveRecord::Migration
  def change
    add_reference :requested_sign_types, :document, index: true
  end
end
