require 'GoogleMapsAPI'
require 'search/DistanceSort'
require 'search/TimeSort'
require 'will_paginate/array'

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
    @num_results = @groups.size
    @groups = @groups.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @full_width = true
    @group = Group.find_by(id: params[:id])
    @group_announcements = @group.announcements
    @group_members = @group.users
    @group_admins = @group.admin_users
    @applied_to_group = (Application.find_by(user: current_user, group_id: params[:id]) != nil) || (@group_members.include?(current_user)) || (@group_admins.include?(current_user))
  end

  def members
    @full_width = true
    @group = Group.find_by(id: params[:id])
    @group_members = @group.users
    @group_admins = @group.admin_users

    @applied_users = @group.user_apps
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
    if application.save
      redirect_to group_page_path
    end
  end

  def about
    @full_width = true
    @group = Group.find_by(id: params[:id])
    @group_members = @group.users
    @group_admins = @group.admin_users
    render 'about'
  end

  def reject
      application = Application.find_by(user_id: params[:user_id], group_id: params[:id])
      if application.destroy
        redirect_to group_members_path
      end
  end

  def accept
    # add the user to the group
    group = Group.find_by(id: params[:id])
    group.users << User.find_by(id: params[:user_id])
    
    # delete the application to the group
    application = Application.find_by(user_id: params[:user_id], group_id: params[:id])
    application.destroy

    if group.save
      redirect_to group_members_path
    end
  end

  def events
    @full_width = true
    @group = Group.find_by(id: params[:id])
    @group_members = @group.users
    @group_admins = @group.admin_users
    @events = @group.events
  end

  def change_image
    group_id = params[:id]
    group = Group.find(group_id)
    group.image_url = params[:image_url]

    if (group.save)
      redirect_to "/group/#{group_id}"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :location, :description, :group_type, :about)
  end
end
