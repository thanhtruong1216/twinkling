class AddDescriptionToPolls < ActiveRecord::Migration[7.2]
  def change
    add_column :polls, :description, :text
  end
end
