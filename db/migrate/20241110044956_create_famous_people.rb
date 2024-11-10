class CreateFamousPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :famous_people do |t|
      t.string :full_name
      t.string :real_name
      t.string :birthday
      t.string :key

      t.timestamps
    end
  end
end
