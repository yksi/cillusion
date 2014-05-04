class RemoveUserAgeAddUserBorndata < ActiveRecord::Migration
  def change
    remove_column :users, :age
    add_column :users, :born_date, :datetime
  end
end
