class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :papers
  has_many :corrections, dependent: :destroy

  scope :all_correctors, -> (id) { where.not(id: id)}

  def has_corrections?
    if Correction.where(user: self).where("grade = 0.0").count > 0
      return true
    else
      return false
    end
  end

  def self.find_grade(corrector, paper_id)
    @grade ||= corrector.corrections.where("paper_id = ?", paper_id).first.grade
  end

  def calculate_score
    self.score = Paper.where(user_id: id).average(:grade).to_f
    self.save
  end

end
