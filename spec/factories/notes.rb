# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    sequence(:subject) {|n| "My Note Nr. #{n}"}
    body "Dies ist meine tolle Notiz. Bitte beachte mich!"
    user {FactoryGirl.create(:customer)}
    request nil
	offer nil
	bugreport nil
	assignment nil
	order nil
	installation nil
	invoice nil
  end
end
