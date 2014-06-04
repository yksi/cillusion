class AddPreferLangToUsers < ActiveRecord::Migration
  def change
    add_column :users, :prefer_lang, :string, default: 'en'
  end
end
