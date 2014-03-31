class AddSignedToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :signed, :boolean
  end
end
