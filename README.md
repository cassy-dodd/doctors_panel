# Doctors Panel

- [Assumptions](#assumptions)
- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)

### Description

A Panel where doctors can log-in and do the following:

1. Get a list of patients that could be assigned to doctor (new patients matching the criteria a doctor has trained for).
2. As a doctor get list of my patients (can be sorted by patient last name or by the closest appointment).
3. As a doctor they can assign themselves to patients (patients without a doctor, matching the criteria a doctor has trained for).

### Assumptions

- We already have registered doctors
- We already have patients
  - with a doctor
  - without a doctor
- Doctors and patients already have some appointments

### Installation

#### Ruby version
2.6.6

#### Rails version
6.0.6.1

#### Database
PostgreSQL


#### Clone the project

```
$ git clone git@github.com:cassy-dodd/doctors_panel.git
$ cd doctors_panel
```
#### Set-up libraries

```
$ bundle install
```

#### Set-up data

```
$ rails db:setup
```

#### Run the server

```
$ rails s
```

### Usage

You can interact with the API endpoints directly using cURL commands or utilize an API development tool such as Postman.

Here is a test Doctor, which can be used to interact with the app:

```
email: 'test_doctor@test.com',
password: 'supersecurepassword1234'
```

- Log in as the doctor
  
```
curl -X POST \
  http://localhost:3000/api/v1/login \
  -H 'Content-Type: application/json' \
  -d '{
    "email": "test_doctor@test.com",
    "password": "supersecurepassword1234" 
  }' 
```
- Upon successful login, store the returned token for furture requests:

#### There are the following endpoints:

- Get a list of patients that could be assigned to doctor (new patients matching the criteria a doctor has trained for).
  
```
curl -X GET \
http://localhost:3000/api/v1/patients -H 'Authorization: Bearer <token>' 
```
- As a doctor they can assign themselves to patients (patients without a doctor, matching the criteria a doctor has trained for).
  
```
curl -X PUT \
  http://localhost:3000/api/v1/patients/<patient_id> \
  -H 'Authorization: Bearer <token>'
```

- As a doctor get list of my patients (can be sorted by patient last name or by the closest appointment).
  
  - by closest appointment
    
    ```
    curl -X GET \
      'http://localhost:3000/api/v1/doctors/patients?sort=appointment' \
      -H 'Authorization: Bearer <token>'
    ```
    
  - by last_name
    
    ```
    curl -X GET \
    'http://localhost:3000/api/v1/doctors/patients?sort=last_name' \
    -H 'Authorization: Bearer <token>'
    ```

### Testing

- the test suite is RSpec. To run through the whole test suite, please run the following:

```
rspec ./
```

- for a specific spec, please run the following:

```
rspec spec/requests/api/v1/patients_spec.rb
```

Thanks for reading! 
