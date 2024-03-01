# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def create
    @doctor = Doctor.find_by(email: login_params[:email])
    if @doctor&.authenticate(login_params[:password])
      # TODO: add serializer and don't expose all model attrs to client
      @token = encode_token(doctor_id: @doctor.id)
      render json: {
        doctor: @doctor,
        token: @token
      }, status: :accepted
    else
      render json: { message: 'unsuccessful login' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end

# Assuming that we already have doctors in our db who want to log-in and access their exisiting/new patients
# TODO: Two step authentication
# if we successfully find a doctor with the provided credentials
#   generate a token to authenticate future requests (we consistently know who is accessing our app)
# TODO: add indications (doctor's should perhaps belong to them as well as patients -> has_many docs and patients)
#  -> separate concerns for future indications to be added, without touching doctor/patient logic
# Indication attrs could be:
# attrs:
#  :name
# TODO: add patients (for doctor's queries)
# from the task:
# * The list can be sorted by patient last name or by the closest appointment.
# 3. As a doctor they can assign themselves to patients
# Patient attrs could be:
# attrs:
#   :first_name,
#   :last_name,
#   :indication_id,
#   :doctor_id (optional if docs can assign themselves = patients without doctors)
# TODO: add appointments
