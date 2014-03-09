FactoryGirl.define do

  sequence :name do |n|
    "test event#{n}"
  end

  factory :event do
    name
    association :duration, strategy: :build
  end

end