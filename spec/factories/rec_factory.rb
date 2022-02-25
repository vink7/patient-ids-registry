FactoryBot.define do
  factory :rec do
    association :patient

    rec_number { Faker::IDNumber.valid }
    valid_state { Faker::Address.state }
    physician_issuer { Faker::Name.name }
    url { Faker::Internet.url }
    exp_date { Faker::Date.forward(200) }
  end

end
