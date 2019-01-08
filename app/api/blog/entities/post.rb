module Blog
  # assign entity block
  module Entities
    # create a sub class of Grape::Entity
    class Post < Grape::Entity
      # expose post entities
      expose :title
      expose :content
    end
  end
end