module Blog
  # invoke version
  module V1
    # invoke helper module          present env["warden"]          present env["warden"]
    module Helpers
      # create authentication helper module
      module AuthenticationHelper extend Grape::API::Helpers
        # check if authenticated
        def authenticated
          return true if @authenticated
          return if request.headers["Authorization"] && JWTBlacklist.find_by_jti(request.headers["Authorization"]).present?
          request.headers["Authorization"] && (@user = UserAccessToken.find_by(access_token: request.headers["Authorization"].sub("Bearer ", "")))
          if @user
            @current_user = @user.user
            @authenticated = true
          end
          return @authenticated
        end

        # return current user
        def current_user
          return @current_user
        end

        # return current user id
        def current_user_id
          return @current_user[:id]
        end
      end
    end
  end
end