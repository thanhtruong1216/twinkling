class AddBirthdayNameAndSexToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :birthday, :string
    add_column :users, :sex, :string
    add_column :users, :name, :string
    add_column :users, :west_zodiac, :string
    add_column :users, :destiny, :string
    add_column :users, :chinese_zodiac, :string
    add_column :users, :zodiac_name_translate, :string
    add_column :users, :zodiac_name_translate_sex, :string
  end
end
