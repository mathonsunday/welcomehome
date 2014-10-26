class AddColumnForFamily < ActiveRecord::Migration
  def change
    add_column :homes, :family, :integer, :default => 0
  end
end
