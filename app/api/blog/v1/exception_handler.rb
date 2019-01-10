module Blog
  # add version
  module V1
    # invoke module
    module ExceptionHandler extend ActiveSupport::Concern
      # list all exceptions
      included do
        rescue_from Exceptions::Unauthorized do |e|
          error!({ error: { status: 401, message: e.message } }, 401)
        end
      end
    end
  end
end