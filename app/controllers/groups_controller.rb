require 'GoogleMapsAPI'
require 'SoundCloudAPI'
require 'YouTubeAPI'
require 'search/DistanceSort'
require 'search/TimeSort'
require 'will_paginate/array'

class GroupsController < ApplicationController
  before_action :set_group_id, only: [:update_about, :update_media, :update_group]
  before_action :set_group_vars, only: [:show, :members, :media, :about, :events, :edit_about, :edit_media, :edit_group]

  def home
    if params[:name].blank?
      @groups = Group.all.to_a
    else
      @groups = Group.where("lower(name) LIKE ?", "%#{params[:name].downcase}%").to_a
    end

    if !(params[:zip].blank?) && @groups.size > 0
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
    @group_announcements = @group.announcements
    @applied_to_group = (Application.find_by(user: current_user, group_id: params[:id]) != nil) || (@group_members.include?(current_user)) || (@group_admins.include?(current_user))
  end

  def members
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
      redirect_to "/group/#{@group.id}"
    else
      render 'new'
    end
  end

  def media
    if !@group.soundcloud_url.blank? && !@group.soundcloud_url.nil?
      @soundcloud_embed_tracks = SoundCloudAPI.get_tracks(@group.soundcloud_url).embed_tracks
    end

    if !@group.youtube_url.blank? && !@group.youtube_url.nil?
      @youtube_embed_tracks = YouTubeAPI.get_videos(@group.youtube_url).embed_videos
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

  def add_admin
    @group = Group.find_by(id: params[:id])
    user = User.find_by(id: params[:user_id])
    @group.admin_users << user

    if @group.save
      redirect_to "/group/#{@group.id}/members"
    end
  end

  def remove_member
    @group = Group.find_by(id: params[:id])
    @group_members = @group.users
    @group_admins = @group.admin_users
    @group.memberships.find_by(user_id: params[:user_id]).destroy

    if @group.save
      redirect_to "/group/#{@group.id}/members"
    end
  end

  def update_about
    if @group.update(group_params)
      redirect_to :group_about, notice: 'About page was successfully updated.'
    else
      render :edit_about
    end
  end

  def update_media
    if @group.update(group_params)
      redirect_to :group_media, notice: 'Media page was successfully updated.'
    else
      render :edit_media
    end
  end

  def update_group
    if @group.update(group_params)
      redirect_to :group_page, notice: 'Group page was successfully updated.'
    else
      render :edit_group
    end
  end

  def edit_about
  end

  def edit_media
  end

  def edit_group
  end

  private

  def set_group_vars
    @full_width = true
    @group = Group.find_by(id: params[:id])
    @group_members = @group.users
    @group_admins = @group.admin_users
  end

  def set_group_id
    @group = Group.find_by(id: params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :location, :description, :group_type, :about, :youtube_url, :soundcloud_url)
  end
end
