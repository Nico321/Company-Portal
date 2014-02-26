require 'spec_helper'

describe "shop" do

let!(:bserver) {FactoryGirl.create(:article, name: "Big Server", description: "This Server is really awesome and will fulfil all your needs. From medium to big sized companies. Try it out!", price: 8999.99, delivertime: 10)}
let!(:mserver) {FactoryGirl.create(:article, name: "Medium Server", description: "This Server is not as awesome as the big one but it is better and faster than the small server. It is best used in small to medium sized companies", price: 3999.99, delivertime: 7)}
let!(:sserver) {FactoryGirl.create(:article, name: "Small Server", description: "A really durable and sophisticated server for all your needs at your own home-network. Use it as a media-server or just to store your data to be protected from that nosey NSA!", price: 999.99, delivertime: 3)}
let!(:computer){FactoryGirl.create(:article, name: "Computer", description: "Just a standard PC for everyday needs. Watching porn or whatever!", price: 599.99, delivertime: 2)}
		
	it 'adds a new line_item to cart' do
		visit store_url
		expect{page.find("##{bserver.id}").click}.to change{LineItem.all.count}.by(1) 
	end

	it 'removes line_item from cart' do
		visit store_url
		page.find("##{bserver.id}").click
		expect{page.find("#decrement#{bserver.line_items.first.id}").click}.to change{LineItem.all.count}.by(-1) 
	end
	
	it 'displays cart in sidebar if its first article' do
		visit store_url
		page.find("##{bserver.id}").click
		page.should have_content "Your Cart"
	end

	it 'hides cart in sidebar if its empty' do
		visit store_url
		page.find("##{bserver.id}").click
		page.find("#delete#{bserver.line_items.first.id}").click
		page.should_not have_content "Your Cart"
	end

	it 'shows added article in sidebar cart' do
		visit store_url
		page.find("##{bserver.id}").click
		page.should have_content '1&times Big Server'
	end

	it 'decrements quantity of line_item if its already in cart' do
		visit store_url
		page.find("##{bserver.id}").click
		page.find("##{bserver.id}").click
		expect{page.find("#decrement#{bserver.line_items.first.id}").click}.to change{LineItem.find(bserver.line_items.first.id).quantity}.by(-1)
	end

	it 'increments quantity of line_item if its already in cart' do
		visit store_url
		page.find("##{bserver.id}").click
		expect{page.find("#increment#{bserver.line_items.first.id}").click}.to change{LineItem.find(bserver.line_items.first.id).quantity}.by(1)
	end

	it 'deletes line_item if quantity is 1 and decrement button is clicked' do
		visit store_url
		page.find("##{bserver.id}").click
		expect{page.find("#decrement#{bserver.line_items.first.id}").click}.to change{LineItem.all.count}.by(-1)
	end

	it 'routes to sign in if user is not logged in and wants to checkout' do
		visit store_url
		page.find("##{bserver.id}").click
		click_on("Checkout")
		page.should have_content("Sign in")
	end

	it 'routes to and creates assignment if user is logged in and checks out' do
		customer = FactoryGirl.create(:customer)
		login(customer)
		visit store_url
		page.find("##{bserver.id}").click
		expect{click_on("Checkout")}.to change{Assignment.all.count}.by(1)
		page.should have_content("Assignment")
	end

end