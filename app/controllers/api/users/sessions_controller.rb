# frozen_string_literal: true

class Api::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  skip_before_action :verify_signed_out_user, only: [:create]

  def create
    user = User.find_by(email: params[:user][:email])
    if user.present?
      user.valid_password?(params[:user][:password])
      render json: { message: "Login successfully", user: user, token: encode_token(user) }, status: :ok
    else
      render json: { message: "Login failed" }, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out(current_user)
    render json: { message: "Logged out successfully" }, status: :ok
  end

  def encode_token(payload)
    JWT.encode({ user_id: payload.id, exp: 24.hours.from_now.to_i, jti: SecureRandom.uuid }, Rails.application.secret_key_base)
  end

end