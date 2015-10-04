class Admin::UsersController < ActionController::Base
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  private
    def user_parasm
      params.require(:user).permit(:email, :password)
    end
end
