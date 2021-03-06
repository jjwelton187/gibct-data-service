# frozen_string_literal: true

FactoryBot.define do
  factory :ipeds_ic_py do
    cross { generate :cross }

    chg1py3 { 133.0 }
    books { 133.0 }

    trait :institution_builder do
      cross { '999999' }
    end

    initialize_with do
      new(cross: cross, chg1py3: chg1py3, books: books)
    end
  end
end
