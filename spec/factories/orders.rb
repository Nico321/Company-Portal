# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    subject "MyString"
    body "MyText"
    installationprice "9.99"
    customer_id 1
    agent_id 1
    installation_id 1
  end
end
