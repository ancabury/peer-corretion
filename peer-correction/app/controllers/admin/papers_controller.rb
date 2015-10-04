class Admin::PapersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @papers = Paper.all
  end

  private
    def find_paper
      paper = Paper.find(params[:paper_id])
    end
end
