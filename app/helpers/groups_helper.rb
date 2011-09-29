module GroupsHelper

  def set_group_template
    @g = params[:group_id] || params[:id]
    if @g.to_i != 0
      @group = Group.find(@g)
    else
      @group = Group.where(:permalink => @g).first
    end
    @category_pages = {10 => [], 11 => [], 12 => []}
    Page.order('category DESC').where(:state => true, :group_id => @group.id).each do |page|
      @category_pages[page.category].push page
    end
  end
end
