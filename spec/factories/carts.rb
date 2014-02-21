# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cart do

  end

  factory :cart_with_some_line_items, class: Cart do
  	ignore do
      line_items_count 3
    end

    after(:create) do |cart, evaluator|
      FactoryGirl.create_list(:some_line_items, evaluator.line_items_count, cart: cart)
    end
  end
  
  factory :cart_with_line_items, class: Cart do
  	ignore do
  		line_items_count 2
  	end

  	after(:create) do |cart, evaluator|
  		FactoryGirl.create_list(:line_item, evaluator.line_items_count, cart: cart)
  	end
  end
end