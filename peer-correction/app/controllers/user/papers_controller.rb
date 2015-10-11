class User::PapersController < ActionController::Base
  layout 'user'
  before_action :authenticate_user!
  before_action :find_paper, only: [:show]

  def index
    @papers = Paper.where('id NOT IN (?) and created_at > ?', Paper.joins(:corrections).pluck(:id).uniq, current_user.last_sign_in_at)
  end

  def new
    @paper = Paper.new
  end

  def create
    @paper = Paper.create(paper_params)
    @paper.user_id = params[:user_id]
    @paper.path = upload
    if @paper.valid?
      @paper.save
      redirect_to   user_user_paper_path(current_user, @paper), flash: { success: "Paper added" }
    else
      render 'new'
    end
  end

  def upload
    name = params[:paper][:paper_file].original_filename
    directory = "public/papers"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(params[:paper][:paper_file].read) }
    path
  end

  def show
    # render file: @paper.path, layout: false, content_type: "text/plain"
  end

  def download
    paper = Paper.find(params[:paper_id])
    send_file paper.path, filename: paper.name, content_type: "text/plain"
  end

  private
    def paper_params
      params.require(:paper).permit(:paper_file, :name)
    end

    def find_paper
      @paper = Paper.find(params[:id])
    end
end
