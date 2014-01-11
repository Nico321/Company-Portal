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

cone = User.create!(:email => "customer1@cp.de", :password => "testtest")
ctwo = User.create!(:email => "customer2@cp.de", :password => "testtest")
eone = User.create!(:email => "employee1@cp.de", :password => "testtest")
etwo = User.create!(:email => "employee2@cp.de", :password => "testtest")

requests = [rone = Request.create!(:subject => "my Request1", :body =>"This is my new Request", :customer_id => cone.id, :urgency => "1", :agent_id => eone.id),
rtwo = Request.create!(:subject => "my Request2", :body =>"This is my new Request", :customer_id => ctwo.id, :urgency => "1", :agent_id => etwo.id),
rthree = Request.create!(:subject => "my Request3", :body =>"This is my new Request", :customer_id => cone.id, :urgency => "2", :agent_id => eone.id),
rfour = Request.create!(:subject => "my Request4", :body =>"This is my new Request", :customer_id => ctwo.id, :urgency => "2", :agent_id => etwo.id),
rfife = Request.create!(:subject => "my Request5", :body =>"This is my new Request", :customer_id => cone.id, :urgency => "3", :agent_id => eone.id),
rsix = Request.create!(:subject => "my Request6", :body =>"This is my new Request", :customer_id => ctwo.id, :urgency => "3", :agent_id => etwo.id)]


requests.each do |r|
	if r.customer.id == cone.id
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => cone.id,:request_id =>r.id)
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => eone.id,:request_id =>r.id)
	else
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => ctwo.id,:request_id =>r.id)
		Note.create!(:subject => "my note1", :body => "This is my Note", :user_id => etwo.id,:request_id =>r.id)
	end
end