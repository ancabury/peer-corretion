class Paper < ActiveRecord::Base
    belongs_to :user
    has_many :corrections, dependent: :destroy
    has_attached_file :paper_file
    validates_attachment_content_type :paper_file, content_type: /(.*).[doc|txt|pdf]/
    validates_presence_of :name, :path

    def grade_it
      self.grade = Correction.where(paper_id: id).average(:grade).to_f
      self.save
    end

end
