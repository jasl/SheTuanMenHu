class Member < ActiveRecord::Base
  belongs_to :profile
  belongs_to :group
end
