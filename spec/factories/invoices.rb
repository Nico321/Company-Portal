# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice do
    sequence(:subject) {|n| "My Invoice Nr. #{n}"}
    body "MyText"
    installationprice "9.99"
    customer {FactoryGirl.create(:customer)}
    installation {FactoryGirl.create(:installation, customer: customer)}
  end
end
