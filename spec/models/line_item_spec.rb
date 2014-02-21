require 'spec_helper'

describe LineItem do
   let!(:cart){FactoryGirl.create(:cart_with_line_items)}
   let!(:article){FactoryGirl.create(:article)}
   let!(:li) {FactoryGirl.create(:line_item, cart: cart, article: article)}

   it 'should not be valid without an article' do
   	 li.article = nil
   	 li.should_not be_valid
   end

   it 'should be valid with an article' do
   	li.should be_valid
   end

   it "should be valid with a cart" do
   		li.should be_valid
   end

   it "should not be valid without a cart" do
   		li.cart = nil
   		li.should_not be_valid
   end
end
