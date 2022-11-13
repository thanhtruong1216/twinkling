class RemoveKeyFromPosts < ActiveRecord::Migration[6.0]
  def up
    remove_column :posts, :key
  end

  def down
  end
end
