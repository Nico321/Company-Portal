# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :businessprocess do
    customerid 1
    subject "MyString"
    request "MyText"
    employeeid 1
    urgency 1
    stateid 1
    discount ""
    offer "MyText"
    installationprice ""
  end
end
