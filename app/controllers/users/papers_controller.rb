class Users::PapersController < ActionController::Base
  layout 'user'
  before_action :authenticate_user!
  before_action :find_paper, only: [:show]

  def index
    @papers = Paper.order(created_at: :desc)
  end

  def new
    @paper = Paper.new
  end

  def create
    @paper = Paper.create(paper_params)
    @paper.user_id = params[:user_id]
    if @paper.valid?
      @paper.save
      redirect_to users_root_path, flash: { success: "Paper added" }
    else
      render 'new'
    end
  end

  private
    def paper_params
      params.require(:paper).permit(:paper_file, :name)
    end

    def find_paper
      @paper = Paper.find(params[:id])
    end
end
