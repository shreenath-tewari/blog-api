module Blog
  # assign version
  module V1
    # assign entity block
    module Entities
      # create a sub class of Grape::Entity
      class Post < Grape::Entity
        # expose post entities
        expose :title
        expose :content
        expose :comments, using: Blog::V1::Entities::Comment
      end
    end
  end
end