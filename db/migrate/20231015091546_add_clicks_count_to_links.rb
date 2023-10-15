class AddClicksCountToLinks < ActiveRecord::Migration[6.1]
  def change
    add_column :links, :clicks_count, :integer, default: 0

    Link.all.each do |link|
      Link.reset_counters(link.id, :clicks)
    end
  end
end
