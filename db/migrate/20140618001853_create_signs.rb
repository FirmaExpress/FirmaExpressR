class CreateSigns < ActiveRecord::Migration
  def change
    create_table :signs do |t|
      t.string :ip

      t.timestamps
    end
  end
end
