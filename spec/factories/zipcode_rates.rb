# frozen_string_literal: true

FactoryGirl.define do
  factory :zipcode_rate do
    zip_code '20001'
    mha_code '123'
    mha_name 'Washington, DC'
    mha_rate 1111
    dod_mha_rate 1100
    mha_rate_grandfathered 1000
  end
end
