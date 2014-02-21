# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
  	quantity 1
    article 
    cart
  end

  factory :some_line_items, class: LineItem do
  	quantity 3
  	article 
    cart
  end
end
