# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    sequence(:subject) {|n| "My Offer Nr. #{n}"}
    body "MyText"
    installationprice "10"
    customer {FactoryGirl.create(:customer)}
    offer {FactoryGirl.create(:offer, customer: customer)}
  end
end
