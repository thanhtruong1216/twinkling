class AddCountryAndCityToVotes < ActiveRecord::Migration[7.2]
  def change
    add_column :votes, :country, :string
    add_column :votes, :city, :string
    add_column :votes, :ip_address, :string
  end
end
