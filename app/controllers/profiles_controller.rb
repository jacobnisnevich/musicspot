class ProfilesController < ApplicationController
  def show
    @user = User.find_by(uid: params[:id])
    if !Profile.find_by(:user_id => @user.id)
      Profile.create(:user_id => @user.id)
    end
    @profile = Profile.select(profile_params).where(:user_id => @user.id).first

  end


  def edit
    @user = User.find_by(uid: params[:id])
    @profile = Profile.select(profile_params).where(:user_id => @user.id).first
  end

  def submit
    puts params[:id]
    @user = User.find_by(uid: params[:id])
    input = params[:profile]
    @profile = Profile.find_by(user_id: @user.id)
    @profile.email = input[:email]
    @profile.musical_role = input[:musical_role]
    @profile.interests = input[:interests]
    @profile.other = input[:other]

    if @profile.save
      redirect_to profile_path
    else
      redirect_to edit_profile_path
    end
  end

  private

    def profile_params
      #if we add a column to a profile, just adding it here should work
      @params = :email, :musical_role, :interests, :other
    end
end
