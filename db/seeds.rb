# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'factory_girl_rails'


##################################
#
# Seeds for roles(Sven)
##################################

superadmin = FactoryGirl.create(:superadmin, :email => "superadmin@example.com")
sales = FactoryGirl.create(:sales, :email => "sales@example.com")
customer = FactoryGirl.create(:customer, :email => "customer@example.com")
accountant = FactoryGirl.create(:accountant, :email => "accountant@exmaple.com")
technician = FactoryGirl.create(:technician, :email => "technician@example.com")

###########################################################
#
# Articles
#
############################################################

bserver = FactoryGirl.create(:article, name: "Big Server", description: "This Server is really awesome and will fulfil all your needs. From medium to big sized companies. Try it out!", price: 8999.99, delivertime: 10, image: File.open("#{Rails.root}/spec/support/fixtures/bigserver.jpg"))
mserver = FactoryGirl.create(:article, name: "Medium Server", description: "This Server is not as awesome as the big one but it is better and faster than the small server. It is best used in small to medium sized companies", price: 3999.99, delivertime: 7, image: File.open("#{Rails.root}/spec/support/fixtures/mediumserver.jpg"))
sserver = FactoryGirl.create(:article, name: "Small Server", description: "A really durable and sophisticated server for all your needs at your own home-network. Use it as a media-server or just to store your data to be protected from that nosey NSA!", price: 999.99, delivertime: 3, image: File.open("#{Rails.root}/spec/support/fixtures/smallserver.jpg"))
computer = FactoryGirl.create(:article, name: "Computer", description: "Just a standard PC for everyday needs. Watching porn or whatever!", price: 599.99, delivertime: 2, image: File.open("#{Rails.root}/spec/support/fixtures/computer.jpg"))
FactoryGirl.create(:article, name: "Keyboard", description: "Basic keyboard for extrem coding", price: 45.99, delivertime: 1, image: File.open("#{Rails.root}/spec/support/fixtures/tastatur.jpg")) 
FactoryGirl.create(:article, name: "Banana", description: "Coding break? Time for a vitamin-containing banana!", price: 1.99, delivertime: 1, image: File.open("#{Rails.root}/spec/support/fixtures/banane.jpg")) 
FactoryGirl.create(:article, name: "Red Bull", description: "Enough coffein for coding all night long!", price: 2.99, delivertime: 1, image: File.open("#{Rails.root}/spec/support/fixtures/redbull.jpg")) 
FactoryGirl.create(:article, name: "Monitor", description: "A basic monitor. 24 Inches. Enough space for multiple Windows.", price: 399.99, delivertime: 2, image: File.open("#{Rails.root}/spec/support/fixtures/monitor.jpg"))
FactoryGirl.create(:article, name: "Network cable", description: "A 5m network cable.!", price: 6.99, delivertime: 2, image: File.open("#{Rails.root}/spec/support/fixtures/lankabel.jpg"))
FactoryGirl.create(:article, name: "Mouse", description: "Great!", price: 100.99, delivertime: 2, image: File.open("#{Rails.root}/spec/support/fixtures/maus.jpg"))
FactoryGirl.create(:article, name: "Graphic card", description: "Enough power to render everything!", price: 333.99, delivertime: 2, image: File.open("#{Rails.root}/spec/support/fixtures/grafikkarte.jpg"))

###########################################################
#
# Seeds for Businessprocess(Nico)
#
###########################################################

requests = Array.new
offers = Array.new
assignments = Array.new
orders = Array.new
installations = Array.new
invoices = Array.new
positions = Array.new

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
 te = FactoryGirl.create(:technician)
	Bugreport.create(subject: "Error 3", description: "I did it", reporter: cu, created_at: Time.now)
 	Bugreport.create(subject: "no Invoice", description: "no", reporter: cu, agent: te, created_at: Time.local(2014,01,21), closed: Time.now)
 	Bugreport.create(subject: "dont want it", description: "description", reporter: cu, agent: te, created_at: Time.local(2014,01,21))

#puts "technician password is #{pass}"
puts "all PWs are testtest"

