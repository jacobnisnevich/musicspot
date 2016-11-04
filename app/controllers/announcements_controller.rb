class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:edit, :update, :destroy]

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

    if @announcement.save
      redirect_to :group_page, notice: 'Announcement was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /announcements/:id
  def update
    if @announcement.update(announcement_params)
      redirect_to :group_page, notice: 'Announcement was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /groups/:id/announcements/
  def destroy
    @announcement.destroy
    redirect_to group_page_path(params[:group_id]), notice: 'Announcement was successfully destroyed.'
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
