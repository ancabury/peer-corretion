class Admin::HomeController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @papers = Paper.where('created_at > ?', current_admin.last_sign_in_at)
  end
end
