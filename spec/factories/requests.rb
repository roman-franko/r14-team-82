FactoryGirl.define do
  factory :request do

    request_string "C++, Java, ASM"

    factory :request_with_entities do
      after(:build) do |req|
       req.entities << create(:entity)
      end
    end
  end
end