class AddCommentToVotes < ActiveRecord::Migration[7.1]
  def change
    add_column :votes, :comment, :text
  end
end
