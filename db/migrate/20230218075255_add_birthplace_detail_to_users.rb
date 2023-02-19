class AddBirthplaceDetailToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :birthplace_detail, :text
  end
end
