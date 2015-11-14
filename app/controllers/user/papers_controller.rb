class User::PapersController < ActionController::Base
  layout 'user'
  before_action :authenticate_user!
  before_action :find_paper, only: [:show]

  def index
    @papers = Paper.order(created_at: :desc)
  end

  def new
    @paper = Paper.new
  end

  def client
    creds  = AWS::Credentials.new(ENV['BUCKETEER_AWS_ACCESS_KEY_ID'], ENV['BUCKETEER_AWS_SECRET_ACCESS_KEY'])
    AWS::S3::Client.new(credentials: creds, region: 'us-east-1')
  end

  def create
    @paper = Paper.create(paper_params)
    @paper.user_id = params[:user_id]
    if @paper.valid?
      @paper.save
      redirect_to user_root_path, flash: { success: "Paper added" }
    else
      # flash[:error]= @paper.errors.messages[:name].first if @paper.errors.messages[:name]
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
