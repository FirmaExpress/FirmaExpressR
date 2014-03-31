class CreateJoinTableParticipants < ActiveRecord::Migration
  def change
    create_join_table :users, :documents, table_name: :participants do |t|
      t.index :user_id
      t.index :document_id
    end
  end
end
