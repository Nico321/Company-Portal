# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :installation do
    subject "MyString"
    body "MyText"
    installationdate "2014-02-18"
    invoice_id 1
    order_id 1
  end
end
