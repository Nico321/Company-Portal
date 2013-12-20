# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do
    article nil
    businessprocess nil
    quantity 1
    deliverydate "2013-12-21"
  end
end
