class User::UsersController < ActionController::Base
  layout 'user'
  before_action :authenticate_user!

  def upload
  end
end
