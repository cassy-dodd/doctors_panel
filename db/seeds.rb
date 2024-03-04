# frozen_string_literal: true

require 'faker'

Rails.logger = Logger.new($stdout)

indication_hair_loss = Indication.create(name: 'hair_loss')
indication_diabetes = Indication.create(name: 'diabetes')
indication_cough = Indication.create(name: 'cough')
indication_rash = Indication.create(name: 'rash')

INDICATIONS = [indication_hair_loss, indication_diabetes, indication_cough, indication_rash].freeze

Rails.logger.info { 'Creating some doctors' }
10.times do
  Doctor.create(name: Faker::Name.unique.first_name,
                email: Faker::Internet.unique.email,
                indication: INDICATIONS.sample,
                password: 'password1234',
                password_confirmation: 'password1234')
end

Rails.logger.info { 'Creating specific test doctor' }
test_doctor = Doctor.create(
  name: Faker::Name.unique.first_name,
  email: 'test_doctor@test.com',
  indication: INDICATIONS.sample,
  password: 'supersecurepassword1234',
  password_confirmation: 'supersecurepassword1234'
)

doctors = Doctor.all

Rails.logger.info { "Creating test doctors' patients and appointments" }
5.times do
  patient = Patient.create(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    email: Faker::Internet.unique.email,
    indication: test_doctor.indication,
    doctor: test_doctor
  )

  Appointment.create(
    patient: patient,
    doctor: test_doctor,
    scheduled_at: Faker::Time.between(from: DateTime.now, to: 1.year.from_now)
  )
end

Rails.logger.info { "Creating doctors' patients and appointments" }
20.times do
  doctor = doctors.sample
  patient_indication = doctor.indication
  patient = Patient.create(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    email: Faker::Internet.unique.email,
    indication: patient_indication,
    doctor: doctor
  )

  Appointment.create(
    patient: patient,
    doctor: doctor,
    scheduled_at: Faker::Time.between(from: DateTime.now, to: 1.year.from_now)
  )
end

Rails.logger.info { 'Creating unassigned patients' }
10.times do
  Patient.create(first_name: Faker::Name.unique.first_name,
                 last_name: Faker::Name.unique.last_name,
                 email: Faker::Internet.unique.email,
                 indication: INDICATIONS.sample)
end
