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
end