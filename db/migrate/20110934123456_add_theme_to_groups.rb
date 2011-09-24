class AddThemeToGroups < ActiveRecord::Migration
  def change
    change_table :groups do |t|
      t.string :theme, :default => 'default'
    end
  end
end