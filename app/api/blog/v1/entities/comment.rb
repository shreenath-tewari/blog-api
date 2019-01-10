module Blog
  # assign version
  module V1
    # assign entity block
    module Entities
      # create a sub class of Grape::Entity
      class Comment < Grape::Entity
        # expose comment entities
        expose :body
      end
    end
  end
end