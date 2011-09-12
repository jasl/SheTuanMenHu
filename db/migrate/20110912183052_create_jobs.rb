class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.references :team
      t.references :group

      t.timestamps
    end
    add_index :jobs, :team_id
    add_index :jobs, :group_id
  end
end
