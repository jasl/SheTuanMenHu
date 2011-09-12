class Member < ActiveRecord::Base
  belongs_to :profile
  belongs_to :job
  belongs_to :team
  belongs_to :group
end
