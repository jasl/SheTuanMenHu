class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :permalink
      t.string :school
      t.string :slogan
      t.string :introduction
      t.boolean :is_audited
      t.timestamp :created_at, :default => Time.now

      t.timestamps
    end
  end
end
