class CreateClicks < ActiveRecord::Migration[6.1]
  def change
    create_table :clicks do |t|
      t.references :link

      t.timestamps
    end
  end
end
