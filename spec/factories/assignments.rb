# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    subject "MyString"
    body "MyText"
    installationprice "9.99"
  end
end
