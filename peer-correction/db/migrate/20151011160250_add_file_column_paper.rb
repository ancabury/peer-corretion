class AddFileColumnPaper < ActiveRecord::Migration
  def change
    add_attachment :papers, :paper_file
    add_column :papers, :path, :string
  end
end
