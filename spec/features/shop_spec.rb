require 'spec_helper'

describe "shop" do

let!(:bserver) {FactoryGirl.create(:article, name: "Big Server", description: "This Server is really awesome and will fulfil all your needs. From medium to big sized companies. Try it out!", price: 8999.99, delivertime: 10, image: File.new("#{Rails.root}/spec/support/fixtures/bigserver.jpg"))}
let!(:mserver) {FactoryGirl.create(:article, name: "Medium Server", description: "This Server is not as awesome as the big one but it is better and faster than the small server. It is best used in small to medium sized companies", price: 3999.99, delivertime: 7, image: File.new("#{Rails.root}/spec/support/fixtures/mediumserver.jpg"))}
let!(:sserver) {FactoryGirl.create(:article, name: "Small Server", description: "A really durable and sophisticated server for all your needs at your own home-network. Use it as a media-server or just to store your data to be protected from that nosey NSA!", price: 999.99, delivertime: 3, image: File.new("#{Rails.root}/spec/support/fixtures/smallserver.jpg"))}
let!(:computer){FactoryGirl.create(:article, name: "Computer", description: "Just a standard PC for everyday needs. Watching porn or whatever!", price: 599.99, delivertime: 2, image: File.new("#{Rails.root}/spec/support/fixtures/computer.jpg"))}
		
	it 'displays cart in sidebar if its first article' do
		visit store_url
		#visit line_items_path(bserver)
		#find('#cart').find('h2').should have_content('Your Cart')
	end

	it 'hides cart in sidebar if its empty' do
		visit store_url
	end

	it 'shows added article in sidebar cart' do
		visit store_url
	end

end