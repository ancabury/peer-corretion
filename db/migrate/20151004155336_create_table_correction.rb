class CreateTableCorrection < ActiveRecord::Migration
  def change
    create_table :corrections do |t|
      t.integer :user_id
      t.integer :paper_id
      t.integer :grade
      t.string :observations

      t.timestamps null: false
    end
  end
end
