class User::CorrectionsController < ApplicationController
  layout 'user'
  before_action :authenticate_user!
  before_action :find_correction, only: [:edit, :update]

  def index
    @corrections = Correction.where(user: current_user).where("grade = 0.0")
  end

  def edit
  end

  def update
    if @correction.update_attributes(correction_params)
      @paper.grade_it
      redirect_to user_user_corrections_path(current_user.id), flash: { success: "Paper graded!" }
    else
      render 'edit'
    end
  end

  private
    def correction_params
      params.require(:correction).permit(:user_id, :paper_id, :grade, :observations)
    end

    def find_paper
      @paper = @correction.paper
    end

    def find_correction
      @correction = Correction.find(params[:id])
      find_paper
    end
end
