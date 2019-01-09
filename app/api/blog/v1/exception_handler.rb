module Blog
  # add version
  module V1
    # invoke module
    module ExceptionHandler extend ActiveSupport::Concern
      # list all exceptions
      included do
      end
    end
  end
end