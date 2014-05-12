class AddOwnerIdToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :owner_id, :integer
  end
end
