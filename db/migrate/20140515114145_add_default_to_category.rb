class AddDefaultToCategory < ActiveRecord::Migration
  def change
    remove_column :articles, :category, :string
    add_column :articles, :category, :string, default: 'Other'
  end
end
