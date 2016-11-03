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

  def apply
    application = Application.new
    application.group_id = params[:id]
    application.user = current_user
    if (application.save)
      redirect_to group_page_path
    end
  end

  private

    def group_params
      params.require(:group).permit(:name, :location, :description, :group_type)
    end

end
