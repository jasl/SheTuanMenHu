class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :authority
      t.references :profile
      t.references :group
      t.boolean :is_audited

      t.timestamps
    end

    add_index :members, :profile_id
    add_index :members, :group_id
    add_index :members, :authority
    add_index :members, :is_audited
  end
end
