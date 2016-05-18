class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]
  before_action :check_existing_profile, only: [:new, :create]

  def show
  end

  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update_attributes(profile_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:name)
    end

    def set_profile
      @profile = current_user.profile
      if !@profile
        redirect_to new_profile_path and return
      end
    end

    def check_existing_profile
      if current_user.profile
        redirect_to edit_profile_path and return
      end
    end
end
