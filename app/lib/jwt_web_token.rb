class JwtWebToken
  class << self
    # encode the data
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    # decode the data
    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      body.with_indifferent_access
    rescue StandardError
      {}
    end
  end
end