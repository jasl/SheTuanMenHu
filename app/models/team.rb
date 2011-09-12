class Team < ActiveRecord::Base
  belongs_to :group
  has_many :jobs, :dependent => :destroy
end
