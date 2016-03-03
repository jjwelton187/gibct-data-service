FactoryGirl.define do
  factory :raw_file_source do
    name "raw_file"
    build_order { (RawFileSource.maximum(:build_order) || 0) + 1 }

    trait :no_name do
    	name nil
    end

    trait :no_order do
      build_order nil
    end

    factory :school_file_source do
      name "school_file"
    end

    factory :weams_file_source do
      name "weams_file"
    end
  end
end
