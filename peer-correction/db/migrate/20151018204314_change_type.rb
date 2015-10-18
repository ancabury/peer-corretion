class ChangeType < ActiveRecord::Migration
  def change
    change_column :corrections, :grade, :float
    change_column :papers, :grade, :float
  end
end
