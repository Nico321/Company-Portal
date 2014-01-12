# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :offer do
    subject "MyString"
    body "MyText"
    installationprice "9.99"
    publication "2014-01-12"
  end
end
