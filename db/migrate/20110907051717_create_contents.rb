class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :group
      t.string :title
      t.string :author
      t.string :source
      t.text :body
      t.boolean :allow_comment
      t.boolean :state

      t.string :type

      t.timestamps :created_at, :default => Time.now
      t.timestamps :updated_at

      t.timestamps
    end
    add_index :contents, :group_id
  end
end
