class AddVisibleToPolls < ActiveRecord::Migration[7.2]
  def change
    add_column :polls, :visible, :boolean
  end
end
