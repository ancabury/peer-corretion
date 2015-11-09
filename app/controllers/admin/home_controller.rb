class Admin::HomeController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @papers = Paper.where('id NOT IN (?) and created_at > ?', Paper.joins(:corrections).pluck(:id).uniq, current_admin.last_sign_in_at)
  end
end
