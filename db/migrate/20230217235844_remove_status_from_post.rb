class RemoveStatusFromPost < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :status, :string
  end
end
