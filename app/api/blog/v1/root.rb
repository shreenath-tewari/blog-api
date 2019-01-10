module Blog
  # invoke version
  module V1
    #invoke class Root
    class Root < Grape::API
      # initialisation properties
      version 'v1'
      format :json
      prefix :api

      # mount different components
      mount Users
      mount Posts
    end
  end
end