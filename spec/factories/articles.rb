# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    sequence(:name) {|n| "My article #{n}"}
    description {"This is my awesome description"}
    image "MyPicture.jpg"
    price "0.01"
    delivertime 1
    supplierid 1
  end
end
