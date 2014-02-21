# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bugreport do
    sequence(:subject) {|n| "My Bugreport #{n}"}
    description "MyText"
    reporter {FactoryGirl.create(:customer)}
    agent {FactoryGirl.create(:superadmin)}
  end
end
