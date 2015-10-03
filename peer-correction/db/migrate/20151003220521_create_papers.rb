class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :name
      t.integer :user_id
      t.integer :grade, default: 0

      t.timestamps null: false
    end
  end
end
