class ProfilesController < ApplicationController
  def show
    @user = User.find_by(uid: params[:id])
    if !Profile.find_by(:user_id => @user.id)
      @profile = Profile.new(:user_id => @user.id)
      for i in 0..167 do
        @profile.availability << "0"
      end

      @profile.save
    end
    
    @profile = Profile.select(profile_params).find_by(:user_id => @user.id)

  end

  def edit
    @user = User.find_by(uid: params[:id])
    @profile = Profile.select(profile_params).find_by(:user_id => @user.id)
  end

  def submit
    @user = User.find_by(uid: params[:id])
    input = params[:profile]
    @profile = Profile.find_by(user_id: @user.id)
    @profile.email = input[:email]
    @profile.musical_role = input[:musical_role]
    @profile.interests = input[:interests]
    @profile.other = input[:other]
    new_profile = Profile.new

    for i in 0..167 do
      new_profile.availability << params[:hours][i.to_s]
    end

    @profile.availability = new_profile.availability

    if @profile.save
      redirect_to profile_path
    else
      redirect_to edit_profile_path
    end
  end

  private

  def profile_params
    # if we add a column to a profile, just adding it here should work
    @params = :email, :musical_role, :interests, :other, :availability
  end
end
