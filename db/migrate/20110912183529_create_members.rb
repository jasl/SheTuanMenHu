class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :authority
      t.references :profile
      t.references :job
      t.references :team
      t.references :group
      t.boolean :is_audited

      t.timestamps
    end
    add_index :members, :profile_id
    add_index :members, :job_id
    add_index :members, :team_id
    add_index :members, :group_id
  end
end
