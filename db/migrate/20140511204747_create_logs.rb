class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :logable_type
      t.integer :logable_id
      t.boolean :viewed, default: false

      t.timestamps
    end
  end
end
