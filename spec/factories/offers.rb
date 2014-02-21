# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :offer do
    sequence(:subject) {|n| "My Offer Nr. #{n}"}
    body "MyText"
    installationprice "9.99"
    customer {FactoryGirl.create(:customer)}
    request {FactoryGirl.create(:request, customer: customer)}
  end
end
