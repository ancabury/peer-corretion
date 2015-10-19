class Admin::CorrectionsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :find_paper, only: [:index, :new, :create]
  before_action :find_correction, only: [:destroy]

  def index
    @correctors = Correction.where("paper_id = ?", params[:paper_id])
  end

  def new
    @correction = Correction.new
  end

  def create
    @correction = Correction.create(correction_params)
    if @correction.valid?
      @correction.save
      redirect_to admin_paper_corrections_path(@paper), flash: { success: "Correctors added" }
    else
      render 'new'
    end
  end

  def delete
    @correction.destroy
    redirect_to admin_paper_corrections_path(@paper), flash: { success: "Corrector destroyed" }
  end

  private
    def correction_params
      params.require(:correction).permit(:user_id, :paper_id, :grade)
    end

    def find_paper
      @paper = Paper.find(params[:paper_id])
    end

    def find_correction
      @correction = Correction.find(params[:id])
    end
end
