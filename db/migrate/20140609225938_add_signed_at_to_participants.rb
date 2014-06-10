class AddSignedAtToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :signed_at, :datetime
  end
end
