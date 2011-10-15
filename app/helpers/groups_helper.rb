module GroupsHelper

  def group_permalink_to_id
    @permalink = params[:group_id] || params[:id]
    params[:group_id] = Group.select(:id).where(:permalink => @permalink).first.id if @permalink.to_i == 0
  end

  def set_group_template
=begin
    @g = params[:group_id] || params[:id]
    if @g.to_i != 0
      @group = Group.find(@g)
    else
      @group = Group.where(:permalink => @g).first
    end
=end
    @group = Group.find(params[:group_id])
    @category_pages = {10 => [], 11 => [], 12 => []}
    Page.order('category DESC').where(:state => true, :group_id => @group.id).each do |page|
      @category_pages[page.category].push page
    end
  end

end
