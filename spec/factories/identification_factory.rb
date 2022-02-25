FactoryBot.define do
  factory :identification do
    association :patient

    id_number { Faker::IDNumber.valid }
    state_issuer { Faker::Address.state }
    url { Faker::Internet.url }
    exp_date { Faker::Date.forward(200) }

  end

  factory :expired_identification do
    association :patient

    id_number { Faker::IDNumber.valid }
    state_issuer { Faker::Address.state }
    url { Faker::Internet.url }
    exp_date { Faker::Date.backward(200) }
  end
end
