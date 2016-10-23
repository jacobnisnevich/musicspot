class GroupsController < ApplicationController
  def home
    if params[:name]
      @groups = Group.where("lower(name) LIKE ?", "%#{params[:name].downcase}%").to_a
    else
      @groups = Group.all.to_a
    end
  end

  def new
    @group = Group.new
  end

  def submit
    @group = Group.new(params.require(:group).permit(:name, :location, :description, :group_type))
    @group.users << current_user
    @group.admin_users << current_user

    @group.save

    redirect_to '/groups'
  end

  def show
    @full_width = true
    @group = Group.find_by(id: params[:id])
    @group_members = @group.users
    @group_admins = @group.admin_users
  end
end
