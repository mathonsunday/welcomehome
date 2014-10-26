class AddColumnForLongTerm < ActiveRecord::Migration
  def change
    add_column :homes, :long_term, :integer, :default => 0
  end
end
