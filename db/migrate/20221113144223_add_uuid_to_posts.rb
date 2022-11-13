class AddUuidToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :uuid, :string
    add_index :posts, :uuid, unique: true
  end
end
