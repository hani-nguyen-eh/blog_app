# frozen_string_literal: true

class Api::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:user][:email])
    if user.present?
      user.valid_password?(params[:user][:password])
      render json: { message: "Login successfully", user: user, token:SecureRandom.uuid }, status: :ok
    else
      render json: { message: "Login failed" }, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out(current_user)
    render json: { message: "Logged out successfully" }, status: :ok
  end

end