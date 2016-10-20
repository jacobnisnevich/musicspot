class GroupsController < ApplicationController
  def home
    
  end

  def new
    @group = Group.new
  end

  def submit
    @group = Group.new(params.require(:group).permit(:name, :location, :description, :group_type))
    @group.users << current_user

    @group.save

    render :home
  end
end
