# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

Home.transaction do
  CSV.foreach('db/export.csv') do |row|
    Home.create(
      :name => row[1],
      :street => row[3],
      :city => row[4],
      :state => row[5],
      :long_term => row[10],
      :family => row[2],
      :directions => row[11],
      :comment => row[12],
      :latitude => row[8],
      :longitude => row[9],
      :country => row[6]
      )
  end
end