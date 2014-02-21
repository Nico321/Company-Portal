require 'spec_helper'

describe "shop" do

let!(:bserver) {Article.create!(name: "Big Server", description: "This Server is really awesome and will fulfil all your needs. From medium to big sized companies. Try it out!", price: 8999.99, delivertime: 10, supplierid: 1, image: "big_server.jpg")}
let!(:mserver) {Article.create!(name: "Medium Server", description: "This Server is not as awesome as the big one but it is better and faster than the small server. It is best used in small to medium sized companies", price: 3999.99, delivertime: 7, supplierid: 1, image: "medium_server.jpg")}
let!(:sserver) {Article.create!(name: "Small Server", description: "A really durable and sophisticated server for all your needs at your own home-network. Use it as a media-server or just to store your data to be protected from that nosey NSA!", price: 999.99, delivertime: 3, supplierid: 1, image: "small_server.jpg")}
let!(:computer){Article.create!(name: "Computer", description: "Just a standard PC for everyday needs. Watching porn or whatever!", price: 599.99, delivertime: 2, supplierid: 1, image: "computer.jpg")} 
		
	it 'creates a new article if the cart is empty' do
			visit store_url
			visit line_items_path(article_id: bserver)
			page.should have_content "Big Server"
	end

	it 'removes an article from current cart' do
			visit store_url
			page.should have_content "Item removed"
	end

	it 'increments quantity of an article' do

	end

	it 'decrements quantity of an article' do
	
	end

	it 'clears the current cart' do

	end

	it 'redirects to shoping page when hitting "go on shopping"' do

	end
end