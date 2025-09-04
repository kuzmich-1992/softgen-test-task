# README

* ruby 2.7.4

* Rails 7.0.4.2

* for clone app you need run 
  git clone https://github.com/kuzmich-1992/softgen-test-task.git

* run bundle install

* for database initialization and install seeds: 
  - configure database.yml file
  - rails db:create
  - rails db:migrate
  - rails db:seed

* To run the test - bundle exec rspec

* Credentials of Admin (appear after run seeds) 
  - Doctor`s categories created but not preseted - assign it for doctors from admin account
  - admin email: "admin@gmail.com", phone: "38096980000", password: "1234567", role: "admin"

* Creds other users (appear after run seeds)
  - doctor_1 email: "doctor1@gmail.com", phone: "38096981111", password: "1234567", role: "doctor"
  - doctor_2 email: "doctor2@gmail.com", phone: "38096981112", password: "1234567", role: "doctor"
  - doctor_3 email: "doctor3@gmail.com", phone: "38096981113", password: "1234567", role: "doctor"
  - patient_1 email: "patient1@gmail.com", phone: "38096981114", password: "1234567", role: "patient"
  - patient_2 email: "patient2@gmail.com", phone: "38096981115", password: "1234567", role: "patient"
  - patient_3 email: "patient3@gmail.com", phone: "38096981116", password: "1234567", role: "patient"

* Run app - rails server
