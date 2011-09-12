class Job < ActiveRecord::Base
  belongs_to :team
  belongs_to :group
end
