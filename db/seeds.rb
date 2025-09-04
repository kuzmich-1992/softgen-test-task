# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

admin = User.create(email: "admin@gmail.com", phone: "38096980000", password: "1234567", role: "admin")
doctor_1 = User.create(email: "doctor1@gmail.com", phone: "38096981111", password: "1234567", role: "doctor")
doctor_2 = User.create(email: "doctor2@gmail.com", phone: "38096981112", password: "1234567", role: "doctor")
doctor_3 = User.create(email: "doctor3@gmail.com", phone: "38096981113", password: "1234567", role: "doctor")
patient_1 = User.create(email: "patient1@gmail.com", phone: "38096981114", password: "1234567", role: "patient")
patient_2 = User.create(email: "patient2@gmail.com", phone: "38096981115", password: "1234567", role: "patient")
patient_3 = User.create(email: "patient3@gmail.com", phone: "38096981116", password: "1234567", role: "patient")
category_1 = Category.create(name: "dentist")
category_2 = Category.create(name: "therapist")
category_3 = Category.create(name: "surgeon")
