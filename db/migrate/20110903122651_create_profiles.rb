class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :name
      t.date :birthday
      t.string :mobile
      t.string :qq
      t.string :email
      t.string :gender
      t.string :number
      t.string :school
      t.string :faculty
      t.string :profession
      t.text :resume
      
      t.timestamps :updated_at

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
