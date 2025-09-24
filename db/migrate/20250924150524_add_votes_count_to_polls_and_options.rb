class AddVotesCountToPollsAndOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :polls, :votes_count, :integer, default: 0, null: false
    add_column :options, :votes_count, :integer, default: 0, null: false
  end
end
