class Paper < ActiveRecord::Base
    belongs_to :user
    has_many :corrections, dependent: :destroy
    has_attached_file :paper_file

    validates_attachment :paper_file,
      content_type: { content_type: ['application/pdf', 'text/plain', 'application/msword',
       'application/vnd.openxmlformats-officedocument.wordprocessingml.document'] }
    validates_attachment_presence :paper_file
    validates_presence_of :name

    def grade_it
      self.grade = Correction.where(paper_id: id).average(:grade).to_f
      self.save
    end

end
