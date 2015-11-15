class Users::UsersController < ActionController::Base
  layout 'user'
  before_action :authenticate_user!

  def index
    @papers = current_user.papers
  end

  private
    def user_parasm
      params.require(:user).permit(:email, :password)
    end
end
