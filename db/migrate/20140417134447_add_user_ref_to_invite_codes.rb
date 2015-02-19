class AddUserRefToInviteCodes < ActiveRecord::Migration
  def change
    add_reference :invite_codes, :user, index: true
  end
end
