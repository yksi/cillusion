class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.integer :article_count

      t.timestamps
    end
  end
end
