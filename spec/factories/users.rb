# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    password 'testtest'
    password_confirmation 'testtest'
    firstname {Faker::Name.first_name}
    lastname {Faker::Name.last_name}
    phone {Faker::PhoneNumber.cell_phone}
    street {Faker::Address.street_name}
    zip "48161"

    factory :superadmin do
        after(:create) {|user| user.add_role(:superadmin)}
    end

    factory :customer do
        after(:create) {|user| user.add_role(:customer)}
    end

    factory :sales do
        after(:create) {|user| user.add_role(:sales)}
    end

    factory :technician do
        after(:create) {|user| user.add_role(:technician)}
    end

    factory :accountant do
        after(:create) {|user| user.add_role(:accountant)}
    end
  end
end
