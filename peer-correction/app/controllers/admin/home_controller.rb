class Admin::HomeController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  private
    def admin_parasm
      params.require(:admin).permit(:email, :password)
    end

    def find_admin
      @admin = Admin.find(params[:id])
    end
end
