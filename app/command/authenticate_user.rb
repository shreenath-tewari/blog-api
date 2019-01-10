class AuthenticateUser
  attr_accessor :login, :password

  def initialize(params)
    @login = params[:login]
    @password = params[:password]
    @user = nil
  end

  def call
    { token: JwtWebToken.encode(user_id: user.id), user: user } if user
  end

  private

  def user
    user = User.find_by(email: login)
    if user.valid_password?(password)
      return user
    end
  end
end