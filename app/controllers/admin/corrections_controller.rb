class Admin::CorrectionsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :find_paper, only: [:index, :new, :create, :destroy]
  before_action :find_correction, only: [:destroy]
  before_action :all_corrections, except: [:destroy]

  def index
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
      redirect_to new_admin_paper_correction_path
    end
  end

  def destroy
    @correction.destroy
    redirect_to admin_paper_corrections_path(@paper), flash: { success: "Corrector destroyed" }
  end

  private
    def all_corrections
      @correctors = Correction.where("paper_id = ?", params[:paper_id])
    end

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
