FactoryGirl.define do

  factory :users_event do
    availability [0,0]
    event
    user
  end

end