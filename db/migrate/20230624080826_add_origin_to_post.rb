class AddOriginToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :origin, :string
  end
end
