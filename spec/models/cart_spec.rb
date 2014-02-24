require 'spec_helper'

describe Cart do
	let!(:cart) {FactoryGirl.create(:cart, :line_items => [FactoryGirl.create(:line_item)])}
	let!(:cart_with_line_items) {FactoryGirl.create(:cart_with_some_line_items)}
	let!(:article) {FactoryGirl.create(:article)}
	
	it 'creates new line_item if article not in cart' do
		expect{cart.add_article(article.id)}.to change{cart.line_items.length}.by(1)
	end

	it 'highers quantity if the same article already in cart' do

	end

	it 'removes a line_item from the cart if its quantity is 1' do

	end

	it 'lowers quantity by one' do

	end
	
end
