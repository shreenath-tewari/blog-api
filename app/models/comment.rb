class Comment < ApplicationRecord
  # establish relationships
  belongs_to :post
  belongs_to :user
end
