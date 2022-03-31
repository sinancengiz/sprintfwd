class CreateMemberProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :member_projects do |t|
      t.references :member, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
