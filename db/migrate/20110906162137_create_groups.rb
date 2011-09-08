class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :school
      t.string :slogan
      t.string :proclaim
      t.string :introduction
      t.boolean :is_audited
      t.timestamp :created_at, :default => Time.now

      t.timestamps
    end
  end
end
