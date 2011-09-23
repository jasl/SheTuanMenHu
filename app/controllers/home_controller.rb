class HomeController < ApplicationController
	
	def index
	  if current_user
      @profile_join_groups = Member.find_all_by_profile_id current_user.profile.id
      @groups = {}
      @profile_join_groups.each do |p|
        @groups = @groups.merge p.group => p.authority
      end
    end
  end

end
