# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do
    quantity 1
    article {FactoryGirl.create(:article)}
    offer {FactoryGirl.create(:offer)}
  end
end
