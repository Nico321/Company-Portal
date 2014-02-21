# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    sequence(:subject) {|n| "My Order Nr. #{n}"}
    body "MyText"
    installationprice "9.99"
    customer {FactoryGirl.create(:customer)}
    assignment {FactoryGirl.create(:assignment, customer: customer)}
  end
end
