FactoryBot.define do
  factory :user do
    email { "tester@gmail.com" }
    password { "123456" }
    name { "tester" }
  end
end
