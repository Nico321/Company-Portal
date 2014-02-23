require 'spec_helper'

describe Cart do
	let!(:cart) {FactoryGirl.create(:cart, :line_items => [FactoryGirl.create(:line_item)])}
	let!(:cart_with_line_items) {FactoryGirl.create(:cart_with_some_line_items)}
	let!(:article) {FactoryGirl.create(:article)}
	
	it 'creates new line_item if article not in cart' do
		cart.save
		expect{cart.add_article(article.id)}.to change{cart.line_items.length}.by(1)
	end

	
end
