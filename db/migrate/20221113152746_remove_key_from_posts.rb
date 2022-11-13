class RemoveKeyFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :key
  end
end
