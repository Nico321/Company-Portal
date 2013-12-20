# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bugreport do
    subject "MyString"
    description "MyText"
    userid 1
    employeeid 1
  end
end
