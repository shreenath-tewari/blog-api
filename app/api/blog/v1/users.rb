module Blog
  # invoke API version
  module V1
    # invoke Grape API for User class
    class Users < Grape::API
      # initialisation properties
      version 'v1'
      format :json
      prefix :api

      # assign users as a resource
      resource :users do
        # initialize helpers
        helpers Blog::V1::Helpers::AuthenticationHelper

        # login controls
        desc 'handles user login'
        # get params
        params do
          requires :login, type: String, desc: 'Login details'
          requires :password, type: String, desc: 'Password'
        end

        # handle post request
        post '/login' do
          auth = AuthenticateUser.new(params)
          response = auth.call
          UserAccessToken.create(access_token: response[:token], user_id: response[:user][:id])
          if response
            status 200
            present response
          else
            status 401
            present message: "Invalid Email or Password"
          end
        end

        # handles logout
        desc 'handles user logout'
        delete '/logout' do
          blacklist = JWTBlacklist.new(jti: request.headers["Authorization"], exp: Time.now)
          if blacklist.save
            status 204
          else
            status 401
            error!({ error: { status: 401, message: 'Unable to Logout' } }, 401)
          end
        end
      end
    end
  end
end