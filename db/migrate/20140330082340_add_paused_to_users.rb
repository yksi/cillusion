class AddPausedToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :paused, default: false
      t.text :about
    end
  end
end
