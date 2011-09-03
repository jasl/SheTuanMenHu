require 'digest'

class User < ActiveRecord::Base
	has_one :profile
	
	acts_as_authentic do |c|
    c.login_field = :email
    c.crypted_password_field = :encrypted_password
    c.password_salt_field = :salt
    c.validate_password_field = false
    c.ignore_blank_passwords = true
  end

  attr_protected :encrypted_password, :salt

  validates :email, :presence => true, :uniqueness => true

  validates :password, :presence => true, :confirmation => true, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  validates :password, :presence => true, :confirmation => true, :on => :update, :unless => "self.password.blank?"
  validates :password_confirmation, :presence => true, :on => :update, :unless => "self.password_confirmation.blank?"

  email_regex = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/i
  validates :email, :format => { :with => email_regex }

  attr_protected :encrypted_password, :salt, :persistence_token
end
