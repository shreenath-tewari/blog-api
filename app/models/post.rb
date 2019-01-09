class Post < ApplicationRecord
  # establish relationships
  has_many :comments, dependent: :destroy
end
