# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice do
    subject "MyString"
    body "MyText"
    installation_id 1
    agent_id 1
    customer_id 1
    installationprice "9.99"
  end
end
