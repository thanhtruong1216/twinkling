class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string     :url, null: false
      t.string     :slug
      t.string     :title
      t.references :user

      t.timestamps
    end
  end
end
