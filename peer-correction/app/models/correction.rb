class Correction < ActiveRecord::Base
    belongs_to :user
    belongs_to :paper

    validates_uniqueness_of :user_id, :scope => [:paper_id]
    # validates_presence_of :grade
end
