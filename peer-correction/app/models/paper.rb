class Paper < ActiveRecord::Base
    belongs_to :user
    has_many :corrections, dependent: :destroy
    has_attached_file :paper_file
    validates_attachment_content_type :paper_file, content_type: /(.*).[doc|txt|docx|pdf]/
end
