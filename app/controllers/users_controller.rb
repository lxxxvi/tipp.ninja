class UsersController < ApplicationController
  before_action :set_user_and_authorize

  def show; end
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :rooting_for_team_id)
  end

  def set_user_and_authorize
    @user = authorize(User.find_by!(url_identifier: params[:id]))
  end
end
