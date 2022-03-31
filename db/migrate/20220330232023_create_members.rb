class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :first_name, presence:true
      t.string :last_name, presence:true
      t.string :city
      t.string :state
      t.string :country
      t.integer :team_id, presence:true

      t.timestamps
    end
  end
end
