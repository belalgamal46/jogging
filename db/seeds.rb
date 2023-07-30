# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(name: 'belal', user_name: 'belalgamal46', email: 'belalgamal00@gmail.com', password: '123456', role: 'admin')
User.create(name: 'abdallah', user_name: 'abdallah', email: 'abdallah@gmail.com', password: '123456', role: 'manager')
User.create(name: 'ahmed', user_name: 'ahmed456', email: 'ahmed@gmail.com', password: '123456')