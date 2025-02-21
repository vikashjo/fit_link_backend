class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :authenticate
    rescue_from JWT::DecodeError, with: :decode_error
    rescue_from JWT::ExpiredSignature, with: :invalid_token

    def authenticate
        header = request.headers['Authorization']
        token = header.split(' ').last if header
        decoded_token = JsonWebToken.decode(token)

        User.find(decoded_token[:user_id])
    end

    def invalid_token
        render json: { error: 'Invalid token' }, status: :unauthorized
    end

    def decode_error
        render json: { error: 'Decode error' }, status: :unauthorized
    end
end
