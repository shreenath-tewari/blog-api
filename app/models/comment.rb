class Comment < ApplicationRecord
  # establish relationships
  belongs_to :post
end
