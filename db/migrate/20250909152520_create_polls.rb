class CreatePolls < ActiveRecord::Migration[7.0]
  def change
    create_table :polls do |t|
      t.string :title, null: false
      t.references :user, null: false, foreign_key: true
      t.string :status, default: "public"

      t.timestamps
    end
  end
end

