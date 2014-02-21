# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :installation do
    sequence(:subject) {|n| "My Installation Nr. #{n}"}
    body "MyText"
    customer {FactoryGirl.create(:customer)}
    order {FactoryGirl.create(:order, customer: customer)}
  end
end
