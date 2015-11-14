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
    # @paper.path = upload
    if @paper.valid?
      @paper.save
      redirect_to user_root_path, flash: { success: "Paper added" }
    else
      # flash[:error]= @paper.errors.messages[:name].first if @paper.errors.messages[:name]
      render 'new'
    end
  end

  def upload
    if params[:paper][:paper_file].nil?
      flash[:error] = "Don't forget to upload the file."
    else
      name = params[:paper][:paper_file].original_filename
      extension = name.split('.')[-1]
      if !['doc', 'txt', 'pdf'].include? extension
        flash[:error] = 'File type is not supported. (only pdf, txt, doc are accepted)'
        nil
      else
        directory = "public/papers"
        path = File.join(directory, name)
        File.open(path, "wb") { |f| f.write(params[:paper][:paper_file].read) }
        path
      end
    end
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
    def paper_params
      params.require(:paper).permit(:paper_file, :name)
    end

    def find_paper
      @paper = Paper.find(params[:id])
    end
end
