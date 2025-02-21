class AuthenticationController < ApplicationController
    skip_before_action :authenticate

    def login
        user = User.find_by(email: params[:email])
        authenticated = user&.authenticate(params[:password])

        if authenticated
            token = JsonWebToken.encode(user_id: user.id)
            expires_at = 24.hours.from_now
            render json: { token: token, expires_at: expires_at }, status: :ok
        else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
    end
end