# frozen_string_literal: true

class PatientFilter
  def initialize(patients, filter_params)
    @patients = patients
    @filter_params = filter_params
  end

  def call
    sorted_by_last_name if @filter_params[:sort] == 'last_name'

    sorted_by_appointment if @filter_params[:sort] == 'appointment'

    @patients
  end

  private

  def sorted_by_last_name
    @patients = @patients.order(:last_name)
  end

  def sorted_by_appointment
    @patients = @patients.joins(:appointments).order('appointments.scheduled_at ASC')
  end
end
