# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

###########################################################
#
# Articles
#
############################################################
bserver = Article.create!(name: "Big Server", description: "This Server is really awesome and will fulfil all your needs. From medium to big sized companies. Try it out!", price: 8999.99, delivertime: 10, supplierid: 1, image: "big_server.jpg")
mserver = Article.create!(name: "Medium Server", description: "This Server is not as awesome as the big one but it is better and faster than the small server. It is best used in small to medium sized companies", price: 3999.99, delivertime: 7, supplierid: 1, image: "medium_server.jpg")
sserver = Article.create!(name: "Small Server", description: "A really durable and sophisticated server for all your needs at your own home-network. Use it as a media-server or just to store your data to be protected from that nosey NSA!", price: 999.99, delivertime: 3, supplierid: 1, image: "small_server.jpg")
computer= Article.create!(name: "Computer", description: "Just a standard PC for everyday needs. Watching porn or whatever!", price: 599.99, delivertime: 2, supplierid: 1, image: "computer.jpg") 
###########################################################
#
# Seeds for Businessprocess(Nico)
#
###########################################################
require 'factory_girl_rails'
requests = Array.new
offers = Array.new
assignments = Array.new
orders = Array.new
installations = Array.new
invoices = Array.new
positions = Array.new

sales = FactoryGirl.create(:sales)
customer = FactoryGirl.create(:customer)

63.times do |i|
	requests.push FactoryGirl.create(:request, customer: customer)
	FactoryGirl.create(:note, user: sales, request: requests[i])
	FactoryGirl.create(:note, user: customer, request: requests[i])
end

54.times do |i|
	offers.push FactoryGirl.create(:offer, customer: customer, request: requests[i])
	FactoryGirl.create(:note, user: sales, offer: offers[i])
	FactoryGirl.create(:note, user: customer, offer: offers[i])
	positions.push FactoryGirl.create(:position, offer: offers[i], article: bserver)
	positions.push FactoryGirl.create(:position, offer: offers[i], article: computer)
end

45.times do |i|
	assignments.push FactoryGirl.create(:assignment, customer: customer, offer: offers[i])
	FactoryGirl.create(:note, user: sales, assignment: assignments[i])
	FactoryGirl.create(:note, user: customer, assignment: assignments[i])
	positions[i].assignment = assignments[i]
	positions[i+1].assignment = assignments[i]
	positions[i].save
	positions[i+1].save
end

36.times do |i|
	orders.push FactoryGirl.create(:order, customer: customer, assignment: assignments[i])
	FactoryGirl.create(:note, user: sales, order: orders[i])
	FactoryGirl.create(:note, user: customer, order: orders[i])
	positions[i].order = orders[i]
	positions[i+1].order = orders[i]
	positions[i].save
	positions[i+1].save
end

27.times do |i|
	installations.push FactoryGirl.create(:installation, customer: customer, order: orders[i])
	FactoryGirl.create(:note, user: sales, installation: installations[i])
	FactoryGirl.create(:note, user: customer, installation: installations[i])
end

18.times do |i|
	invoices.push FactoryGirl.create(:invoice, customer: customer, installation: installations[i])
	FactoryGirl.create(:note, user: sales, invoice: invoices[i])
	FactoryGirl.create(:note, user: customer, invoice: invoices[i])
	positions[i].invoice = invoices[i]
	positions[i+1].invoice = invoices[i]
	positions[i].save
	positions[i+1].save

end

9.times do |i|
	invoices[i].payed = DateTime.now
	invoices[i].save
end

###########################################################
#
# Seeds for Bugreports(Daniel)
#
###########################################################
 cu = FactoryGirl.create(:customer)
 te = FactoryGirl.create(:technican)
	Bugreport.create(subject: "Error 3", description: "I did it", reporter: cu, created_at: Time.now)
 	Bugreport.create(subject: "no Invoice", description: "no", reporter: cu, agent: te, created_at: Time.local(2014,01,21), closed: Time.now)
 	Bugreport.create(subject: "dont want it", description: "description", reporter: cu, agent: te, created_at: Time.local(2014,01,21))

##################################
#
# Seeds for roles(Sven)
##################################

pass = SecureRandom.hex(5)
superadmin = User.create email:'superadmin@example.com', password: 'testtest',
password_confirmation: 'testtest'
# has problem with name admin so superadmin role is better
superadmin.add_role :superadmin
#puts "Admin password is #{pass}"
############

pass = SecureRandom.hex(5)
sales = User.create email:'sales@example.com', password: 'testtest',
password_confirmation: 'testtest'

sales.add_role :sales
#puts "Sales password is #{pass}"
###########

pass = SecureRandom.hex(5)
customer = User.create email:'customer@example.com', password: 'testtest',
password_confirmation: 'testtest'

customer.add_role :customer
#puts "Customer password is #{pass}"
##########

pass = SecureRandom.hex(5)
accountend = User.create email:'accountend@example.com', password: 'testtest',
password_confirmation: 'testtest'

accountend.add_role :accountend
#puts "Accountend password is #{pass}"
##########

pass = SecureRandom.hex(5)
technican = User.create email:'technican@example.com', password: 'testtest',
password_confirmation: 'testtest'

technican.add_role :technican
#puts "Technican password is #{pass}"
puts all PWs are "testtest"