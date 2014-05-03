class AddGroupIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :group_id, :integer
  end
end
