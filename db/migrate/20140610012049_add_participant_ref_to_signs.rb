class AddParticipantRefToSigns < ActiveRecord::Migration
  def change
    add_reference :signs, :participant, index: true
  end
end
