class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

  # GET /groups/:id
  def index
    @full_width = true
    @group = Group.find_by(id: params[:id])
    @group_announcements = @group.announcements
    @group_members = @group.users
    @group_admins = @group.admin_users
    @applied_to_group = Application.find_by(user: current_user, group_id: params[:id]) != nil
  end

  # GET /groups/:id/announcement
  def new
    @announcement = Announcement.new
  end

  # GET /announcements/1/edit
  def edit
  end

  # POST /groups/:id
  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.group_id = params[:id]

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to :group_page, notice: 'Announcement was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to :group_page, notice: 'Announcement was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url, notice: 'Announcement was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:title, :description)
    end
end
