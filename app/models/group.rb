class Group < ActiveRecord::Base
  has_many :contents
  has_many :teams
end
