# frozen_string_literal: true

class RemoveColumnFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :image, :string
  end
end
