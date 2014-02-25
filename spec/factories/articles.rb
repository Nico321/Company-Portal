# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    sequence(:name) {|n| "My article #{n}"}
    description {"This is my awesome description"}
    image { File.new("#{Rails.root}/spec/support/fixtures/image.png")}
    price "0.01"
    delivertime 1
  end
end
