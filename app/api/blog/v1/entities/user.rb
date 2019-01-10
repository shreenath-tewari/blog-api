module Blog
  # assign version
  module V1
    # assign entity block
    module Entities
      # create a sub class of Grape::Entity
      class User < Grape::Entity
        # expose user entities
        expose :name
        expose :email
      end
    end
  end
end