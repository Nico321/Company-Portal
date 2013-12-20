# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    name "MyString"
    image "MyText"
    price ""
    delivertime 1
    supplierid 1
  end
end
