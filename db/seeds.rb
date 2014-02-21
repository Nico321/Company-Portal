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
	Position.create!(:quantity => 5, :article_id =>bserver.id, :offer_id => o.id)
	Position.create!(:quantity => 20, :article_id =>computer.id, :offer_id => o.id)
	Position.create!(:quantity => 50, :article_id =>mserver.id, :offer_id => o.id)
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
