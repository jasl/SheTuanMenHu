class Group < ActiveRecord::Base
  has_many :contents, :dependent => :destroy
  has_many :members, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true
  validates :permalink, :presence => true, :uniqueness => true
  validates :school, :presence => true

  name_regex = /[^x00-xff]/u
  permalink_regex = /^[a-z]{4,}/i

  validates :permalink, :format => { :with => permalink_regex }
  validates :name, :format => { :with => name_regex }
  validates :school, :format => { :with => name_regex }

end
