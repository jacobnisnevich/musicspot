class GroupsController < ApplicationController
  def home
    @groups = Group.all.to_a
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

  def update
    if params[:name]
      @groups = Group.where("lower(name) LIKE ?", "%#{params[:name].downcase}%").to_a
    else 
      # do nothing
    end

    render json: @groups.map!(&:as_json).to_json
  end
end
