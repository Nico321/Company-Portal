# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    subject "MyString"
    body "MyText"
    stateid 1
    imageurl "MyText"
    businessprocessid 1
  end
end
