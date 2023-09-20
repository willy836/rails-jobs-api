class JsonWebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  
    def self.encode(payload)
      JWT.encode(payload, SECRET_KEY, 'HS256')
    end
  
    def self.decode(token)
      begin
        decoded_payload = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')[0]
      rescue JWT::DecodeError
        nil
      end
    end
end