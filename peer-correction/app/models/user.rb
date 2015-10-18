class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :papers
  has_many :corrections, dependent: :destroy

  USERS = User.all

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

end
