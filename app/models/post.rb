class Post < ApplicationRecord
  include Visible

  belongs_to :user
end
