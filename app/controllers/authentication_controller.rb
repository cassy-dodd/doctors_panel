# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def create
    @doctor = Doctor.find_by(email: login_params[:email])
    if @doctor&.authenticate(login_params[:password])
      # TODO: add serializer and don't expose all model attrs to client
      render json: @doctor, status: :accepted
    else
      render json: { message: 'unsuccessful login' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
