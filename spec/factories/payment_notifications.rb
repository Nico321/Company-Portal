# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_notification do
    params "MyText"
    invoice_id 1
    status "MyString"
    transaction_id "MyString"
    create "MyString"
  end
end
