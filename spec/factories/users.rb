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
    zip {Faker::Address.zip_code}

    factory :superadmin do
        after(:create) {|user| user.add_role(:superadmin)}
    end

    factory :customer do
        after(:create) {|user| user.add_role(:customer)}
    end

    factory :sales do
        after(:create) {|user| user.add_role(:sales)}
    end

    factory :technican do
        after(:create) {|user| user.add_role(:technican)}
    end

    factory :accountend do
        after(:create) {|user| user.add_role(:accountend)}
    end
  end
end
