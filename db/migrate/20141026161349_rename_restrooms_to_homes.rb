class RenameRestroomsToHomes < ActiveRecord::Migration
  def change
    rename_table :restrooms, :homes
  end
end
