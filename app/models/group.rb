class Group < ActiveRecord::Base
  has_many :contents

  validates :name, :presence => true, :uniqueness => true
  validates :permalink, :presence => true, :uniqueness => true
  validates :school, :presence => true

end
