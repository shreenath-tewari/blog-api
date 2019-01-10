class User < ApplicationRecord
  attr_accessor :access_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  # establish relationships
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_access_tokens

  # JWT Authentication
  def on_jwt_dispatch(token, _payload)
    p "Token : #{token}"
    self.access_token = token
    user_access_tokens.create(access_token: token)
  end
end
