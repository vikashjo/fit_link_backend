class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :authenticate
    rescue_from JWT::DecodeError, with: :decode_error
    rescue_from JWT::ExpiredSignature, with: :invalid_token

    def authenticate
        header = request.headers['Authorization']
        token = header.split(' ').last if header
        puts "Token: #{token}" # Debugging line to check the token
        decoded_token = JsonWebToken.decode(token) if token
        
        if decoded_token
            puts "Decoded Token: #{decoded_token}" # Debugging line to check the decoded token
            @current_user = User.find(decoded_token[:user_id]) if decoded_token[:user_id]
        else
            puts "No decoded token" # Debugging line
        end
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :unauthorized
    rescue JWT::DecodeError, JWT::ExpiredSignature
        render json: { error: 'Invalid token' }, status: :unauthorized
    end

    def invalid_token
        render json: { error: 'Invalid token' }, status: :unauthorized
    end

    def decode_error
        render json: { error: 'Decode error' }, status: :unauthorized
    end
end
