class RenameColumnsOfComments < ActiveRecord::Migration
  def change
    remove_column :comments, :user
    remove_column :comments, :article
    add_column :comments, :user_id, :integer
    add_column :comments, :article_id, :integer
  end
end
