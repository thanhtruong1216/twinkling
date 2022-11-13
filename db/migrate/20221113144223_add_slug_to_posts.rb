class AddSlugToPosts < ActiveRecord::Migration[6.0]
  def up
    add_column :posts, :slug, :string
    add_index :posts, :slug, unique: true
  end

  def down
  end
end
