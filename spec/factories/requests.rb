# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :request do
    subject "MyString"
    body "MyText"
    urgency 1
    customer c
  end
end
