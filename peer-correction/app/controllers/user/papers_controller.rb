class User::PapersController < ActionController::Base
  layout 'user'
  before_action :authenticate_user!

  def index
    @papers = Paper.where('id NOT IN (?) and created_at > ?', Paper.joins(:corrections).pluck(:id).uniq, current_user.last_sign_in_at)
  end

  def upload
  end
end
