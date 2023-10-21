class CreateEventTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :event_tracks do |t|
      t.references :user
      t.string     :name
      t.timestamps
    end
  end
end
