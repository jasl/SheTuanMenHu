class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :encrypted_password
	  	t.string :persistence_token
	  	t.string :salt
      t.string :last_login_ip
      t.timestamp :last_login_at
      t.timestamp :created_at, :default => Time.now

      t.timestamps
    end
  end
end
