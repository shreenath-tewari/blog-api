class Post < ApplicationRecord
  # establish relationships
  has_many :comments
end
