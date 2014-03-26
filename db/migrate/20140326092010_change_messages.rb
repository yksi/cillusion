class ChangeMessages < ActiveRecord::Migration
  def self.up
    remove_column :messages, :read
    change_table :messages do |t|
      t.boolean :read, default: false
    end
  end
end
