class Admin::PapersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :find_paper, only: [:show, :destroy]

  def index
    @papers = Paper.all
  end

  def show
  end

  def destroy
    @paper.destroy
    redirect_to  admin_papers_path , flash: { success: "Paper deleted" }
  end

  def download
    paper = Paper.find(params[:paper_id])
    send_file paper.path, filename: paper.name, content_type: "text/plain"
  end

  private
    def find_paper
      @paper = Paper.find(params[:id])
    end
end
