class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :article_id
      t.integer :viewer_id

      t.timestamps
    end
    add_index :views, :article_id
    add_index :views, :viewer_id
    add_index :views, [:viewer_id, :article_id], unique: true
  end
end
