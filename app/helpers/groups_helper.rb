module GroupsHelper
  def group_header
    @g = params[:group_id] || params[:id]
    if @g.to_i != 0
      @group = Group.find(@g)
    else
      @group = Group.where(:permalink => @g).first
    end
    @pages = Page.order('created_at DESC').where(:state => true, :group_id => @group.id)
  end
end
