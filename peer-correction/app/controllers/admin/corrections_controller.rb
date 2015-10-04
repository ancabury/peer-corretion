class Admin::CorrectionsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :find_paper, only: [:index]

  def index
    @correctors = User.joins(:corrections).where("paper_id = ?", params[:paper_id])
  end

  def new
    @correction = Correction.new
  end

  def create
    @correction = Correction.create(correction_params)
    if @correction.valid?
      @correction.save
      redirect_to  admin_root_url, flash: { success: "Correctors added" }
    else
      render 'new'
    end
  end

  private
    def correction_params
      params.require(:correction).permit(:user_id, :paper_id)
    end

    def find_paper
      @paper = Paper.find(params[:paper_id])
    end

end
