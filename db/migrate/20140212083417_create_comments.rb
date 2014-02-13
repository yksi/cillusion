class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :article
      t.integer :user
      t.timestamps
    end
  end
end
