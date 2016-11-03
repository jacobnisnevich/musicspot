require 'GoogleMapsAPI'
require 'search/DistanceSort'
require 'search/TimeSort'

class GroupsController < ApplicationController
  def home
    if params[:name].blank?
      @groups = Group.all.to_a
    else
      @groups = Group.where("lower(name) LIKE ?", "%#{params[:name].downcase}%").to_a
    end

    if !(params[:zip].blank?)
      destinations_zips = @groups.map { |g| g.location }
      @destinations = GoogleMapsAPI.get_distances(params[:zip], destinations_zips)
      @strategy = params[:search]
      if params[:search] == "distance"
        strategy = DistanceSort.new
      else
        strategy = TimeSort.new
      end
      @groups = strategy.sort(@groups, @destinations)
    end
  end

  def new
    @group = Group.new
  end

  def submit
    @group = Group.new(group_params)
    @group.users << current_user
    @group.admin_users << current_user

    if (@group.save)
      redirect_to '/groups'
    else
      render 'new'
    end
  end

  def show
    @full_width = true
    @group = Group.find_by(id: params[:id])
    @group_members = @group.users
    @group_admins = @group.admin_users
  end

  def apply
    application = Application.new
    application.user << current_user
    application.group_id << params.find[:id]
    application.save
  end

  def about
    @group = Group.find_by(id: params[:id])
    @group_members = @group.users
    @group_admins = @group.admin_users
    render 'about'
  end

  private

    def group_params
      params.require(:group).permit(:name, :location, :description, :group_type, :about)
    end

end
