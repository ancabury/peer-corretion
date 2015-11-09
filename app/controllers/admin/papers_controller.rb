class Admin::PapersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :find_paper, only: [:show, :destroy]

  def index
    @papers = Paper.all
  end

  def destroy
    @paper.destroy
    redirect_to  admin_papers_path , flash: { success: "Paper deleted" }
  end

  def download
    paper = Paper.find(params[:paper_id])
    extension = paper.paper_file_file_name.split('.')[-1]
    if ['doc', 'txt', 'pdf'].include? extension
      send_file paper.path, filename: paper.name, type: paper.paper_file_content_type, :x_sendfile=>true
    else
      redirect_to :back, flash: { error: 'The file type is not supported. (only pdf, txt, doc are accepted)' }
    end
  end

  private
    def find_paper
      @paper = Paper.find(params[:id])
    end
end
