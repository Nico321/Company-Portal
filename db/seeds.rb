# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


###########################################################
#
# Seeds for Request(Nico)
#
###########################################################
if User.where("email like 'customer1@cp.de'").first == nil
	cone = User.create!(:email => "customer1@cp.de", :password => "testtest")
else
	cone = User.where("email like 'customer1@cp.de'").first
end

if User.where("email like 'customer2@cp.de'").first == nil
	ctwo = User.create!(:email => "customer2@cp.de", :password => "testtest")
else
	ctwo = User.where("email like 'customer2@cp.de'").first
end

if User.where("email like 'employee1@cp.de'").first == nil
	eone = User.create!(:email => "employee1@cp.de", :password => "testtest")
else
	eone = User.where("email like 'employee1@cp.de'").first
end

if User.where("email like 'employee2@cp.de'").first == nil
	etwo = User.create!(:email => "employee2@cp.de", :password => "testtest")
else
	etwo = User.where("email like 'employee2@cp.de'").first
end

requests = [Request.create!(:subject => "my Request1", :body =>"This is my new Request", :customer_id => cone.id, :urgency => "1", :agent_id => eone.id),
Request.create!(:subject => "my Request2", :body =>"This is my new Request", :customer_id => ctwo.id, :urgency => "1", :agent_id => etwo.id),
Request.create!(:subject => "my Request3", :body =>"This is my new Request", :customer_id => cone.id, :urgency => "2", :agent_id => eone.id),
Request.create!(:subject => "my Request4", :body =>"This is my new Request", :customer_id => ctwo.id, :urgency => "2", :agent_id => etwo.id),
Request.create!(:subject => "my Request5", :body =>"This is my new Request", :customer_id => cone.id, :urgency => "3", :agent_id => eone.id),
Request.create!(:subject => "my Request6", :body =>"This is my new Request", :customer_id => ctwo.id, :urgency => "3", :agent_id => etwo.id)]

requests.each do |r|
	if r.customer.id == cone.id
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => cone.id,:request_id =>r.id)
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => eone.id,:request_id =>r.id)
	else
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => ctwo.id,:request_id =>r.id)
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => etwo.id,:request_id =>r.id)
	end
end

offerrequests = [Request.create!(:subject => "my Request1", :body =>"This is my new Request", :customer_id => cone.id, :urgency => "1", :agent_id => eone.id),
Request.create!(:subject => "my Request2", :body =>"This is my new Request", :customer_id => ctwo.id, :urgency => "1", :agent_id => etwo.id),
Request.create!(:subject => "my Request3", :body =>"This is my new Request", :customer_id => cone.id, :urgency => "2", :agent_id => eone.id),
Request.create!(:subject => "my Request4", :body =>"This is my new Request", :customer_id => ctwo.id, :urgency => "2", :agent_id => etwo.id),
Request.create!(:subject => "my Request5", :body =>"This is my new Request", :customer_id => cone.id, :urgency => "3", :agent_id => eone.id),
Request.create!(:subject => "my Request6", :body =>"This is my new Request", :customer_id => ctwo.id, :urgency => "3", :agent_id => etwo.id)]

aserver = Article.create!(:name => "Server", :price => 200, :description => "Heftiger Server!")
acomputer = Article.create!(:name => "Computer", :price => 100, :description => "Cooler Computer!")
atasta = Article.create!(:name => "Tastatur", :price => 10, :description => "Coole Tastatur!")

offerrequests.each do |oreq|
	if oreq.customer.id == cone.id
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => cone.id,:request_id =>oreq.id)
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => eone.id,:request_id =>oreq.id)
	else
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => ctwo.id,:request_id =>oreq.id)
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => etwo.id,:request_id =>oreq.id)
	end
	o = Offer.new(:subject => oreq.subject, :body => "Test Body", :customer_id => oreq.customer.id, :agent_id => oreq.agent.id)
	o.request = oreq
	o.save
	Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => oreq.customer.id,:offer_id =>o.id)
	Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => oreq.agent.id,:offer_id =>o.id)
	Position.create!(:quantity => 5, :article_id =>aserver.id, :offer_id => o.id)
	Position.create!(:quantity => 20, :article_id =>acomputer.id, :offer_id => o.id)
	Position.create!(:quantity => 50, :article_id =>atasta.id, :offer_id => o.id)
end

###########################################################
#
# Seeds for Bugreports(Daniel)
#
###########################################################
b1 = Bugreport.create!(:subject => "New Bugreport", :description => "42", :reporter => cone)
b2 = Bugreport.create!(:subject => "New Bugreport", :description => "42", :reporter => ctwo)
b3 = Bugreport.create!(:subject => "New Bugreport", :description => "42", :reporter => cone, :agent => ctwo)
b4 = Bugreport.create!(:subject => "New Bugreport", :description => "42", :reporter => ctwo, :agent => cone, :created_at =>"2013-02-03T04:05:06+07:00" ,:closed => "2013-02-03T09:05:06+07:00")

##################################
#
# Seeds for roles(Sven)
##################################

pass = SecureRandom.hex(5)
superadmin = User.create email:'superadmin@example.com', password: 'testtest',
password_confirmation: 'testtest'
# has problem with name admin so superadmin role is better
superadmin.add_role :superadmin
puts "Admin password is #{pass}"
############

pass = SecureRandom.hex(5)
sales = User.create email:'sales@example.com', password: 'testtest',
password_confirmation: 'testtest'

sales.add_role :sales
puts "Sales password is #{pass}"
###########

pass = SecureRandom.hex(5)
customer = User.create email:'customer@example.com', password: 'testtest',
password_confirmation: 'testtest'

customer.add_role :customer
puts "Customer password is #{pass}"
##########

pass = SecureRandom.hex(5)
accountend = User.create email:'accountend@example.com', password: 'testtest',
password_confirmation: 'testtest'

accountend.add_role :accountend
puts "Accountend password is #{pass}"
##########

pass = SecureRandom.hex(5)
technican = User.create email:'technican@example.com', password: 'testtest',
password_confirmation: 'testtest'

technican.add_role :technican
puts "Technican password is #{pass}"



