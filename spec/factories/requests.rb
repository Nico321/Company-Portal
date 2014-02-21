# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :request do
  	sequence(:subject) {|n| "My Request #{n}"}
    body "Ich haette gerne einen neuen Server und 5 Computer"
    urgency 1
    customer {FactoryGirl.create(:customer)}
  end
end
